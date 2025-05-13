{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.ai = {
    windsurf = {
      enable = mkEnableOption "Enable windsurf agentic editor";
    };
  };
}
