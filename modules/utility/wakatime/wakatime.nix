{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.utility.wakatime = {
    enable = mkEnableOption "Track time in code";
  };
}
