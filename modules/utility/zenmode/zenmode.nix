{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.zenmode = {
    enable = mkEnableOption "Enable distraction free writing";
  };
}
