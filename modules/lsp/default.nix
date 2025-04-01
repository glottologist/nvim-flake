_: {
  imports = [
    # nvim lsp support
    ./config.nix
    ./module.nix

    ./lspconfig
    ./lspsaga
    ./null-ls

    # lsp plugins
    ./lspsaga
    ./nvim-code-action-menu
    ./actions-preview-nvim
    ./trouble
    ./lsp-signature
    ./lightbulb
    ./lspkind
  ];
}
