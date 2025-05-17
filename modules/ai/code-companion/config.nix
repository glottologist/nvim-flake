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
                        vim.api.nvim_set_keymap("v", "<leader>cpa", ":lua require'codecompanion'.prompt('audit')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpa", ":lua require'codecompanion'.prompt('audit')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpc", ":lua require'codecompanion'.prompt('comment')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpc", ":lua require'codecompanion'.prompt('comment')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpp", ":lua require'codecompanion'.prompt('pair')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpp", ":lua require'codecompanion'.prompt('pair')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpt", ":lua require'codecompanion'.prompt('tests')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpt", ":lua require'codecompanion'.prompt('tests')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpm", ":lua require'codecompanion'.prompt('mnemonic')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpm", ":lua require'codecompanion'.prompt('mnemonic')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpi", ":lua require'codecompanion'.prompt('interview')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpi", ":lua require'codecompanion'.prompt('interview')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpx", ":lua require'codecompanion'.prompt('expert')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpx", ":lua require'codecompanion'.prompt('expert')<cr>", opts)

                        vim.api.nvim_set_keymap("v", "<leader>cpl", ":lua require'codecompanion'.prompt('language')<cr>", opts)
                        vim.api.nvim_set_keymap("n", "<leader>cpl", ":lua require'codecompanion'.prompt('language')<cr>", opts)



                      require("codecompanion").setup({
                      prompt_library= ${prompts},
                      opts = {
                   log_level = "DEBUG", -- or "TRACE"
                 },
                      display = {
                      chat = {
                        start_in_insert_mode = true,
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
