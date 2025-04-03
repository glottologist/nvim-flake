{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.ai;
  prompts = builtins.readFile ./prompts.lua;
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

      -- custom prompts
                        vim.api.nvim_set_keymap("v", "<leader>cpe", ":lua require'codecompanion'.prompt('audit')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpe", ":lua require'codecompanion'.prompt('audit')<cr>", opts)


                      require("codecompanion").setup({
                      prompt_library= ${prompts},
                      opts = {
                   log_level = "DEBUG", -- or "TRACE"
                 },
                      display = {
                      chat = {
                      show_settings =true,
                      },
                             action_palette = {
                               provider = "telescope",
                                 show_default_prompt_library = true,
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
