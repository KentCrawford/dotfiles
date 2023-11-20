local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- -- need ripgrep to get this to work.  will have to build from source
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- -- vim.keymap.set('n', '<leader>fg', function()
-- --     builtin.grep_string({ search = vim.fn.input("Grepp > ") });
-- -- end)
