{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.lsp = {
    actionsPreview = {
      enable = mkEnableOption "Enable nvim actions preview menu";
    };
  };
}
