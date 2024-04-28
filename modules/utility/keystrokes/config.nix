{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utility.keystrokes;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "keystrokes"
    ];
    vim.configRC.keystrokes = nvim.dag.entryAnywhere ''
      autocmd CursorHold <buffer> KeystrokesStart
    '';
  };
}
