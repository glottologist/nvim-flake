{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.zenmode = {
    enable = mkEnableOption "Enable distraction free writing";
  };
}
