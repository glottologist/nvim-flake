{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.ai;
in {
  config = mkIf (cfg.windsurf.enable) {
    vim.startPlugins = ["windsurf"];

  };
}
