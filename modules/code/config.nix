{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.code;
in {
  config = mkIf (cfg.leetcode.enable) {
    vim.startPlugins = ["leet-code-nvim"];
  };
}
