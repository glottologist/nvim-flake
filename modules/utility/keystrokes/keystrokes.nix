{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.keystrokes = {
    enable = mkEnableOption "Log keystrokes to file";
  };
}
