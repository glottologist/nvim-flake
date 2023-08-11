{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.eyeliner = {
    enable = mkEnableOption "Enable quick jumps";
  };
}
