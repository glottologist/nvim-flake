{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.tabline.nvimBufferline;
in {
  config = mkIf cfg.enable (
    let
      mouse = {
        right = "'vertical sbuffer %d'";
        close = ''
          function(bufnum)
            require("bufdelete").bufdelete(bufnum, false)
          end
        '';
      };
    in {
      vim.startPlugins = [
        (assert config.vim.visuals.nvimWebDevicons.enable == true; "nvim-bufferline-lua")
        "bufdelete-nvim"
      ];

      vim.nnoremap = {
        "<silent><leader>bcn" = ":BufferLineCycleNext<CR>";
        "<silent><leader>bcp" = ":BufferLineCyclePrev<CR>";
        "<silent><leader>bp" = ":BufferLinePick<CR>";
        "<silent><leader>bse" = ":BufferLineSortByExtension<CR>";
        "<silent><leader>bsd" = ":BufferLineSortByDirectory<CR>";
        "<silent><leader>bsi" = ":lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>";
        "<silent><leader>bmn" = ":BufferLineMoveNext<CR>";
        "<silent><leader>bmp" = ":BufferLineMovePrev<CR>";
        "<silent><leader>bm1" = "<Cmd>BufferLineGoToBuffer 1<CR>";
        "<silent><leader>bm2" = "<Cmd>BufferLineGoToBuffer 2<CR>";
        "<silent><leader>bm3" = "<Cmd>BufferLineGoToBuffer 3<CR>";
        "<silent><leader>bm4" = "<Cmd>BufferLineGoToBuffer 4<CR>";
        "<silent><leader>bm5" = "<Cmd>BufferLineGoToBuffer 5<CR>";
        "<silent><leader>bm6" = "<Cmd>BufferLineGoToBuffer 6<CR>";
        "<silent><leader>bm7" = "<Cmd>BufferLineGoToBuffer 7<CR>";
        "<silent><leader>bm8" = "<Cmd>BufferLineGoToBuffer 8<CR>";
        "<silent><leader>bm9" = "<Cmd>BufferLineGoToBuffer 9<CR>";
      };

      vim.luaConfigRC.nvimBufferline = nvim.dag.entryAnywhere ''
        require("bufferline").setup{
           options = {
              mode = "buffers",
              numbers = "both",
              close_command = ${mouse.close},
              right_mouse_command = ${mouse.right},
              indicator = {
                style = 'underline',
                -- indicator_icon = '▎',
              },
              buffer_close_icon = '',
              modified_icon = '●',
              close_icon = '',
              left_trunc_marker = '',
              right_trunc_marker = '',
              max_name_length = 18,
              max_prefix_length = 15,
              tab_size = 18,
              show_buffer_icons = true,
              show_buffer_close_icons = true,
              show_close_icon = true,
              show_tab_indicators = true,
              persist_buffer_sort = true,
              --separator_style = "thin",
              separator_style = { " ", " " },
              enforce_regular_tabs = true,
              always_show_bufferline = true,
              offsets = {
                {filetype = "NvimTree", text = "File Explorer", text_align = "center"}
              },
              sort_by = 'extension',
              diagnostics = "nvim_lsp", -- TODO: use coc if it's enabled
              diagnostics_update_in_insert = true,
              diagnostics_indicator = function(count, level, diagnostics_dict, context)
                 local s = ""
                 for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and ""
                       or (e == "warning" and "" or "" )
                    if(sym ~= "") then
                    s = s .. " " .. n .. sym
                    end
                 end
                 return s
              end,
              numbers = function(opts)
                return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
              end,
           }
        }
      '';
    }
  );
}
