{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.ai = {
    claude-code = {
      enable = mkEnableOption "Enable claude code";

    };
  };
}
