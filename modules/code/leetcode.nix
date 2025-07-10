{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.code = {
    leetcode = {
      enable = mkEnableOption "Enable Leet Code";
    };
  };
}
