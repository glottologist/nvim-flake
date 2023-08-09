{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.git;
in {
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.gitsigns.enable (mkMerge [
      {
        vim.startPlugins = ["gitsigns-nvim"];

        vim.luaConfigRC.gitsigns = nvim.dag.entryAnywhere ''
          require('gitsigns').setup {
            keymaps = {
              noremap = true,

              ['n <leader>ghn'] = { expr = true, "&diff ? \'\' : '<cmd>Gitsigns next_hunk<CR>'"},
              ['n <leader>ghp'] = { expr = true, "&diff ? \'\' : '<cmd>Gitsigns prev_hunk<CR>'"},

              ['n <leader>ghs'] = '<cmd>Gitsigns stage_hunk<CR>',
              ['v <leader>ghs'] = ':Gitsigns stage_hunk<CR>',
              ['n <leader>ghu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
              ['n <leader>ghr'] = '<cmd>Gitsigns reset_hunk<CR>',
              ['v <leader>ghr'] = ':Gitsigns reset_hunk<CR>',
              ['n <leader>gbr'] = '<cmd>Gitsigns reset_buffer<CR>',
              ['n <leader>ghv'] = '<cmd>Gitsigns preview_hunk<CR>',
              ['n <leader>gl'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
              ['n <leader>gbs'] = '<cmd>Gitsigns stage_buffer<CR>',
              ['n <leader>gbi'] = '<cmd>Gitsigns reset_buffer_index<CR>',
              ['n <leader>gts'] = ':Gitsigns toggle_signs<CR>',
              ['n <leader>gtn'] = ':Gitsigns toggle_numhl<CR>',
              ['n <leader>gtl'] = ':Gitsigns toggle_linehl<CR>',
              ['n <leader>gtw'] = ':Gitsigns toggle_word_diff<CR>',
              -- Text objects
              ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
              ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
            },
          }
        '';
      }

      (mkIf cfg.gitsigns.codeActions {
        vim.lsp.null-ls.enable = true;
        vim.lsp.null-ls.sources.gitsigns-ca = ''
          table.insert(
            ls_sources,
            null_ls.builtins.code_actions.gitsigns
          )
        '';
      })
    ]))
  ]);
}
