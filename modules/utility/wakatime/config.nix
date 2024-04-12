{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utility.wakatime;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "wakatime"
    ];
  };
}
