{
  config,
  lib,
  ...
}:
with lib;
with builtins; {
  options.vim.ai = {
    code-companion = {
      enable = mkEnableOption "Enable code companion";

      adapter = mkOption {
        type = types.str;
        default = "anthopic";
        description = "AI adapter to use with code companion";
      };

    };
  };
}
