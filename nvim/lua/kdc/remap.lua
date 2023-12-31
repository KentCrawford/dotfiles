vim.g.mapleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "<leader>s", ":sort<CR>")
vim.keymap.set("n", "<leader>t", ":lua todo_toggle()<CR>")
vim.keymap.set("v", "<leader>t", ":lua todo_toggle_v()<CR>")

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<M-k>'] = cmp.mapping.select_prev_item(),
    ['<M-j>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.confirm({select = true}),
  }
})
