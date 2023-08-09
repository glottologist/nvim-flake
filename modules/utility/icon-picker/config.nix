{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.utility.icon-picker;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = [
      "icon-picker-nvim"
      "dressing-nvim"
    ];

    vim.luaConfigRC.icon-picker = nvim.dag.entryAnywhere ''
      require("icon-picker").setup({
        disable_legacy_commands = true
      })

      local opts = { noremap = true, silent = true }

       vim.keymap.set("n", "<Leader>in", "<cmd>IconPickerNormal<cr>", opts)
       vim.keymap.set("n", "<Leader>iy", "<cmd>IconPickerYank<cr>", opts)
       vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
    '';
  };
}
