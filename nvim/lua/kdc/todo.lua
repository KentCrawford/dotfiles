local function escape(v)
  local e = v
  local to_escpae = {"[", "]", "-", "(", ")"}
  for _, c in ipairs(to_escpae) do
    e = e:gsub("%"..c, "%%"..c)
  end
  return e
end

-- local BOX = "☐"
-- local CHECK = "☑"
local BOX = "[ ]"
local CHECK = "[x]"


local TODO_SET_DONE = true
local BOX_ESCAPED = escape(BOX)
local CHECK_ESCAPED = escape(CHECK)


local function toggle_done_date(s)
  local m = string.match(s, " %[done:: %d+%-%d+-%d+%]")
  if m ~= nil then
    s = string.gsub(s, escape(m), "")
  else
    s = s..os.date(" [done:: %Y-%m-%d]")
  end
  return s
end


local function update_vars()
  if vim.g.todo_box then
    BOX = vim.g.todo_box
  end
  if vim.g.todo_check then
    CHECK = vim.g.todo_check
  end
  if vim.g.todo_set_done ~= nil then
    TODO_SET_DONE = vim.g.todo_set_done
  end
  BOX_ESCAPED = escape(BOX)
  CHECK_ESCAPED = escape(CHECK)
end


local function todo_toggle(line)
  local new_line = line
  local len_added = 0

  local idx_square, _ = string.find(new_line, BOX_ESCAPED)
  local idx_check, _ = string.find(new_line, CHECK_ESCAPED)
  -- check for spaces and/or list prefixes (10., a., -, *, +)
  -- local idx_first_non_space = string.len(string.match(new_line, "%s*%w?%.?-?%*?%+?%s?")) + 1
  local idx_first_non_space = string.match(new_line, "%s*%a%.%s?")
  if idx_first_non_space == nil then
    idx_first_non_space = string.match(new_line, "%s*%d?%.?-?%*?%+?%s?")
  end
  idx_first_non_space = string.len(idx_first_non_space) + 1

  if idx_square == nil and idx_check == nil then
    -- checkbox does not yet exists
    local idx_non_space = idx_first_non_space
    local box_space = BOX .. " "
    len_added = string.len(BOX) + 1
    if idx_non_space == nil then
      new_line = box_space
    else
      new_line = new_line:sub(1, idx_non_space - 1)..box_space..new_line:sub(idx_non_space)
    end
  elseif idx_square ~= nil and idx_square >= 0 then
    -- box to checked
    new_line = new_line:gsub(BOX_ESCAPED, CHECK)
    if TODO_SET_DONE == true then
      new_line = toggle_done_date(new_line)
    end
  elseif idx_check >= 0 then
    -- checked to box
    new_line = new_line:gsub(CHECK_ESCAPED, BOX)
    if TODO_SET_DONE == true then
      new_line = toggle_done_date(new_line)
    end
  end
  return new_line, len_added
end


local function todo_toggle_n()
  update_vars()
  local line = vim.api.nvim_get_current_line()
  local idx_line = vim.api.nvim_win_get_cursor(0)[1]
  local idx_cur = vim.api.nvim_win_get_cursor(0)[2]
  local len_added = 0
  line, len_added = todo_toggle(line)
  vim.api.nvim_set_current_line(line)
  vim.api.nvim_win_set_cursor(0, {idx_line, idx_cur+len_added})
end


local function todo_toggle_v()
  update_vars()
  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  for idx_line = start_line, end_line do
    local line = vim.api.nvim_buf_get_lines(0, idx_line - 1, idx_line, false)[1]
    line, _ = todo_toggle(line)
    vim.api.nvim_buf_set_lines(0, idx_line - 1, idx_line, false, {line})
  end
end


local function test()
  local X, _ = todo_toggle("a. this is a test")
  print(X)
  X, _ = todo_toggle(X)
  print(X)
  X, _ = todo_toggle(X)
  print(X)
end


-- test()
_G.todo_toggle = todo_toggle_n
_G.todo_toggle_v = todo_toggle_v
