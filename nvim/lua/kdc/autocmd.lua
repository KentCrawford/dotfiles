vim.api.nvim_create_autocmd({"ColorScheme"}, {
  pattern = {"*"},
  command = "highlight ExtraWhitespace ctermbg=lightred guibg=lightred"
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
  pattern = {"*"},
  command = "match ExtraWhitespace /\\s\\+$/"
})


vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.mako", "*.mak", "*.jinja2", "*.tpl"},
  callback = function(ev)
    vim.opt.ft = "html"
  end
})

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"html", "xml", "xslt", "css", "sql", "javascript", "lua"},
  callback = function(ev)
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end
})

--vim.cmd([[
--autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
--au InsertLeave * match ExtraWhitespace /\s\+$/
--]])
-- vim.ipt.numberwidth = 2
