require('mason').setup()

vim.api.nvim_create_user_command('MasonBootstrap', function(opts)
  vim.cmd([[:MasonInstall typescript-language-server eslint-lsp css-lsp html-lsp]])
end, {
    desc = "Bootstrap Mason by installing a few select packages."
})
