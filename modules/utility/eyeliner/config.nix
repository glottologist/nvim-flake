{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utility.eyeliner;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "eyeliner"
    ];

    vim.nnoremap = {
      "<leader>et" = "<cmd> EyelinerToggle<CR>";
    };

    vim.luaConfigRC.eyeliner = nvim.dag.entryAnywhere ''
       require'eyeliner'.setup {
        highlight_on_key = true,
        dim = false           
      }
    '';
  };
}
