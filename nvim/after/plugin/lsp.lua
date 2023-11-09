if is_debian() then
  local lsp_zero = require('lsp-zero')
  lsp_zero.preset('recommended')
  lsp_zero.setup()

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
  end)
end

require('mason').setup({})

if is_debian() then
  require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
      lsp_zero.default_setup,
    },
  })
elseif is_red_hat() then
  require('mason-lspconfig').setup({})
  require("lspconfig").gopls.setup {}
  require("lspconfig").pyright.setup {}
end
