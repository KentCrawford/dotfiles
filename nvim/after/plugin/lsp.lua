 	local lsp_zero = require('lsp-zero')
 	lsp_zero.preset('recommended')
 	lsp_zero.setup()


 	lsp_zero.on_attach(function(client, bufnr)
 		-- see :help lsp-zero-keybindings
 		-- to learn the available actions
 		lsp_zero.default_keymaps({buffer = bufnr})
 	end)

 	require('mason').setup({})

 	require('mason-lspconfig').setup({
 		ensure_installed = {'lua_ls', 'pyright', 'gopls'},
 		handlers = {
 			lsp_zero.default_setup,
      lua_ls = function()
        -- (Optional) configure lua language server
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end,
      gopls = function()
      	require("lspconfig").gopls.setup {}
      end,
      pyright = function()
        require("lspconfig").pyright.setup {}
      end,
 		},
 	})




--
-- if is_debian() then
-- 	local lsp_zero = require('lsp-zero')
-- 	lsp_zero.preset('recommended')
-- 	lsp_zero.setup()


-- 	lsp_zero.on_attach(function(client, bufnr)
-- 		-- see :help lsp-zero-keybindings
-- 		-- to learn the available actions
-- 		lsp_zero.default_keymaps({buffer = bufnr})
-- 	end)

-- 	require('mason').setup({})

-- 	require('mason-lspconfig').setup({
-- 		ensure_installed = {},
-- 		handlers = {
-- 			lsp_zero.default_setup,
-- 		},
-- 	})
-- elseif is_red_hat() then
-- 	require('mason').setup({})
-- 	require('mason-lspconfig').setup({})
-- 	require("lspconfig").gopls.setup {}
-- 	require("lspconfig").pyright.setup {}
-- end

-- -- to get rid of global vim error message
-- -- maybe consider this: https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
-- require'lspconfig'.lua_ls.setup {
--   settings = {
--     Lua = {
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--     },
--   },
-- }
