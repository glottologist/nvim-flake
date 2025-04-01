{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.ai;
  adapter = config.vim.ai.code-companion.adapter;
in {
  config = mkIf (cfg.code-companion.enable) {
    vim.startPlugins = ["code-companion-nvim"];

    vim.luaConfigRC.code-companion = nvim.dag.entryAnywhere ''

           local opts = { noremap=true, silent=true }

             vim.api.nvim_set_keymap("v", "<leader>ca", "<cmd>CodeCompanionActions<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>ch", "<cmd>CodeCompanionChat Toggle<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>cb", ":lua require'codecompanion'.prompt('buffer')<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>cc", ":lua require'codecompanion'.prompt('commit')<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>ce", ":lua require'codecompanion'.prompt('explain')<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>cf", ":lua require'codecompanion'.prompt('fix')<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>cl", ":lua require'codecompanion'.prompt('lsp')<cr>", opts)
             vim.api.nvim_set_keymap("v", "<leader>ct", ":lua require'codecompanion'.prompt('test')<cr>", opts)

             vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>ch", "<cmd>CodeCompanionChat Toggle<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>c+", "<cmd>CodeCompanionChat Add<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>cb", ":lua require'codecompanion'.prompt('buffer')<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>cc", ":lua require'codecompanion'.prompt('commit')<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>ce", ":lua require'codecompanion'.prompt('explain')<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>cf", ":lua require'codecompanion'.prompt('fix')<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>cl", ":lua require'codecompanion'.prompt('lsp')<cr>", opts)
             vim.api.nvim_set_keymap("n", "<leader>ct", ":lua require'codecompanion'.prompt('test')<cr>", opts)


           require("codecompanion").setup({
           opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
           display = {
                  action_palette = {
                    provider = "telescope"
                  },
                },
                       strategies = {
                  cmd= {
                    adapter = "${adapter}",
                  },
                         chat = {
                    adapter = "${adapter}",
                         },
                         inline = {
                    adapter = "${adapter}",
                         },
                       },
                   })

    '';
  };
}
