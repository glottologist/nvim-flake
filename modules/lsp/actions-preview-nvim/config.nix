{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
in {
  config = mkIf (cfg.enable && cfg.actionsPreview.enable) {
    vim.startPlugins = ["actions-preview-nvim"];

    vim.nnoremap = {
        "<silent><leader>la" = "<cmd>lua require('actions-preview').code_actions()<CR>";
    };
  };
}
