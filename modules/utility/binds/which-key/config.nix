{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.binds.whichKey;
in {
  config = mkIf (cfg.enable) {
    vim.startPlugins = ["which-key"];

    vim.luaConfigRC.whichkey = nvim.dag.entryAnywhere ''
      local wk = require("which-key")
      wk.setup ({
        key_labels = {
          ["<space>"] = "SPACE",
          ["<leader>"] = "SPACE",
          ["<cr>"] = "RETURN",
          ["<tab>"] = "TAB",
        },
          triggers_nowait = {},
      })

      wk.register({

        ${
        if config.vim.binds.cheatsheet.enable
        then ''
          -- Help
          ["<leader>h"] = {
             name = "+Help",
              c = { "<cmd>Cheatsheet<cr>", "Show cheatsheet" },
          },
        ''
        else ""
      }
        ${
        if config.vim.utility.zenmode.enable
        then ''
          -- ZenMode
          ["<leader>z"] = {
            name = "+ZenMode",
             t =  { "<cmd> ZenMode<CR>", "Toggle ZenMode" },
            },
        ''
        else ""
      }
        ${
        if config.vim.tabline.nvimBufferline.enable
        then ''
          -- Buffer
          ["<leader>b"] = {
            name = "+Buffer",
             p = { "<cmd> BufferLinePick<CR>", "Pick Buffer" },
             c = {
              name = "+Cycle",
              n = { "<cmd> BufferLineCycleNext<CR>", "Next Buffer" },
              p = { "<cmd> BufferLineCyclePrev<CR>", "Prev Buffer" },
             },
             x = {
              name = "+Close",
              l = { "<cmd> BufferLineCloseLeft<CR>", "Close All to the Left" },
              r = { "<cmd> BufferLineCloseRight<CR>", "Close All to the Right" },
             },
            s = {
              name = "+Sort",
              e = { "<cmd> BufferLineSortByExtension<CR>", "Sort By Extension" },
              d = { "<cmd> BufferLineSortByDirectory<CR>", "Sort By Directory" },
              i = { "<cmd> lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>", "Sort By ID"  },
            },

            m = {
              name = "+Move",
              n = { "<cmd> BufferLineMoveNext<CR>", "Move to Next" },
              p = { "<cmd> BufferLineMovePrev<CR>", "Move to Previous" },
            },
          },
          ["<leader>bm1"] = { "<cmd> BufferLineGoToBuffer 1<CR>", "Move to Buffer 1" },
          ["<leader>bm2"] = { "<cmd> BufferLineGoToBuffer 2<CR>", "Move to Buffer 2" },
          ["<leader>bm3"] = { "<cmd> BufferLineGoToBuffer 3<CR>", "Move to Buffer 3" },
          ["<leader>bm4"] = { "<cmd> BufferLineGoToBuffer 4<CR>", "Move to Buffer 4" },
          ["<leader>bm5"] = { "<cmd> BufferLineGoToBuffer 5<CR>", "Move to Buffer 5" },
          ["<leader>bm6"] = { "<cmd> BufferLineGoToBuffer 6<CR>", "Move to Buffer 6" },
          ["<leader>bm7"] = { "<cmd> BufferLineGoToBuffer 7<CR>", "Move to Buffer 7" },
          ["<leader>bm8"] = { "<cmd> BufferLineGoToBuffer 8<CR>", "Move to Buffer 8" },
          ["<leader>bm9"] = { "<cmd> BufferLineGoToBuffer 9<CR>", "Move to Buffer 9" },
        ''
        else ""
      }

        ${
        if config.vim.telescope.enable
        then ''
          ["<leader>f"] = { name = "+Find" },
           -- Telescope
          ["<leader>ft"] = { "<cmd> Telescope<CR>" , "Find" },
          ["<leader>ff"] = { "<cmd> Telescope find_files<CR>" , "Find Files" },
          ["<leader>fp"] = { "<cmd> Telescope live_grep<CR>", " Live Grep" },
          ["<leader>fb"] = { "<cmd> Telescope buffers<CR>",  "Find Buffers" },
          ["<leader>fh"] = { "<cmd> Telescope help_tags<CR>",  "Find Help Tags" },
          ["<leader>fg"] = { name = "+Git" },
          ["<leader>fgc"] = { "<cmd> Telescope git_commits<CR>",  "Find Git Commits" },
          ["<leader>fgb"] = { "<cmd> Telescope git_bcommits<CR>", "Find Git Branches" },
          ["<leader>fgf"] = { "<cmd> Telescope git_branches<CR>",  "Find Git Buffer Commits" },
          ["<leader>fgs"] = { "<cmd> Telescope git_status<CR>",  "Find Git Status" },
          ["<leader>fgh"] = { "<cmd> Telescope git_stash<CR>", "Find Git Stash" },
        ''
        else ""
      }

        ${
        if config.vim.telescope.enable && config.vim.lsp.enable
        then ''
          ["<leader>fl"] = { name = "+LSP" },
          ["<leader>flr"] = { "<cmd> Telescope lsp_references<CR>",  "Language References" },
          ["<leader>fli"] = { "<cmd> Telescope lsp_implementations<CR>",  "Language Implementations" },
          ["<leader>fld"] = { "<cmd> Telescope lsp_definitions<CR>", "Language Definitions" },
          ["<leader>flt"] = { "<cmd> Telescope lsp_type_definitions<CR>",  "Language Type Definitions" },
          ["<leader>flg"] = { "<cmd> Telescope diagnostics<CR>",  "Language Diagnostics" },
          ["<leader>fls"] = { name = "+Symbols" },
          ["<leader>flsd"] = { "<cmd> Telescope lsp_document_symbols<CR>", "Document Symbols" },
          ["<leader>flsw"] = { "<cmd> Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" },
        ''
        else ""
      }

        ${
        if config.vim.treesitter.enable
        then ''
          ["<leader>fs"] = { "<cmd> Telescope treesitter<CR>", "Find in Treesitter" },
        ''
        else ""
      }





      ${
        if config.vim.lsp.enable
        then ''
          ["<leader>l"] = { name = "+Language" },
          ["<leader>lg"] = { name = "+Go To" },
          ["<leader>lgd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition" },
          ["<leader>lgc"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go To Declaration" },
          ["<leader>lgt"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go To Type Definition" },
          ["<leader>lw"] = { name = "+Workspace" },
          ["<leader>lwa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",  "Add Workspace" },
          ["<leader>lwr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",  "Remove Workspace" },
          ["<leader>lwl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspaces" },
          ["<leader>lh"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
          ["<leader>ls"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
          ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
          ["<leader>ld"] = { name = "+Diagnostics" },
          ["<leader>ldn"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
          ["<leader>ldp"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic" },

        ''
        else ""
      }



        ${
        if config.vim.lsp.trouble.enable
        then ''
          -- Trouble
          ["<leader>ldt"] =  { "<cmd>TroubleToggle<CR>","Toggle Diagnostics" },
          ["<leader>ldw"] = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
          ["<leader>ldd"] = { "<cmd>TroubleToggle lsp_references<CR>","Document Diagnostics" },
          ["<leader>ldr"] = { "<cmd>TroubleToggle lsp_references<CR>","LSP References" },
          ["<leader>ldq"] = { "<cmd>TroubleToggle quickfix<CR>","Quickfix" },
          ["<leader>ldl"] = { "<cmd>TroubleToggle loclist<CR>","LOC List" },
        ''
        else ""
      }

      ${
        if config.vim.lsp.lspsaga.enable
        then ''
          ["<leader>lf"] = { "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", "Find" },
          ["<leader>lh"] = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", "Hover" },
          ["<leader>lr"] = { "<cmd>lua require'lspsaga.rename'.rename()<CR>",  "rename" },
          ["<leader>lp"] = { name = "+Preview" },
          ["<leader>lpd"] = { "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",  "Preview Definition" },
          ["<leader>ldl"] = { "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",  "Line Diagnostics" },
          ["<leader>ldc"] = { "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>",  "Cursor Diagnostics" },
          ["<leader>ldp"] = { "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",  "Previous Diagnostic" },
          ["<leader>ldn"] = { "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", "Next Diagnostic" },
        ''
        else ""
      }

      ${
        if config.vim.ai.code-companion.enable
        then ''
          ["<leader>c"] = { name = "+Companion" },
          ["<leader>ca"] = { ":CodeCompanionActions<cr>", "Companion Actions" };
          ["<leader>ch"] = { ":CodeCompanionChat Toggle<cr>", "Chat Toggle" };
          ["<leader>cb"] = { ":lua require'codecompanion'.prompt('buffer')<cr>", "Buffer" };
          ["<leader>cc"] = { ":lua require'codecompanion'.prompt('commit')<cr>", "Commit" };
          ["<leader>ce"] = { ":lua require'codecompanion'.prompt('explain')<cr>", "Explain" };
          ["<leader>cf"] = { ":lua require'codecompanion'.prompt('fix')<cr>", "Fix" };
          ["<leader>cl"] = { ":lua require'codecompanion'.prompt('lsp')<cr>", "Lsp" };
          ["<leader>ct"] = { ":lua require'codecompanion'.prompt('test')<cr>", "Test" };
        ''
        else ""
      }



      ${
        if config.vim.lsp.nvimCodeActionMenu.enable
        then ''
          ["<leader>la"] = { "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",  "Code Action Menu" },
        ''
        else ""
      }
      ${
        if config.vim.lsp.lspSignature.enable
        then ''
          ["<leader>ls"] = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", "Signature Help" },
        ''
        else ""
      }


        ${
        if config.vim.filetree.nvimTreeLua.enable
        then ''
          -- NvimTree
          ["<leader>t"] = { name = "+Tree" },
          ["<leader>tt"] = { "<cmd>NvimTreeToggle<CR>", "Toggle" },
          ["<leader>tr"] = { "<cmd>NvimTreeRefresh<CR>", "Refresh" },
          ["<leader>tg"] = { "<cmd>NvimTreeFindFile<cCR>", "Find File" },
          ["<leader>tf"] = { "<cmd>NvimTreeFocus<CR>", "Focus" },

        ''
        else ""
      }

        ${
        if config.vim.git.gitsigns.enable
        then ''
          -- Git
          ["<leader>g"] = { name = "+Git" },
          ["<leader>gl"] = { "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", "Blame line" },
          ["<leader>gh"] = { name = "+Hunk" },
          ["<leader>ghn"] = { "<cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
          ["<leader>ghp"] = { "<cmd>Gitsigns prev_hunk<CR>",  "Previous Hunk" },
          ["<leader>ghs"] = { "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk" },
          ["<leader>ghu"] = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" },
          ["<leader>ghr"] = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
          ["<leader>ghv"] = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
          ["<leader>gb"] = { name = "+Buffer" },
          ["<leader>gbr"] = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
          ["<leader>gbs"] = { "<cmd>Gitsigns stage_buffer<CR>", "Stage Buffer" },
          ["<leader>gbi"] = { "<cmd>Gitsigns reset_buffer_index<CR>","Reset Buffer Index" },
          ["<leader>gt"] = { name = "+Toggle" },
          ["<leader>gts"] = { ":Gitsigns toggle_signs<CR>",  "Toggle Git Signs" },
          ["<leader>gtn"] = { ":Gitsigns toggle_numhl<CR>",  "Toggle Number Highlighting" },
          ["<leader>gtl"] = { ":Gitsigns toggle_linehl<CR>",  "Toggle Line Highlighting" },
          ["<leader>gtw"] = { ":Gitsigns toggle_word_diff<CR>", "Toggle Word Diff" },
        ''
        else ""
      }


        ${
        if config.vim.terminal.toggleterm.enable
        then ''
          -- Terminal
          ["<leader>k"] = { name = "+Terminal" },
          ["<leader>kt"] = { name =  "toggle" },
        ''
        else ""
      }

        ${
        if config.vim.utility.icon-picker.enable
        then ''
          -- Icon Picker
          ["<leader>i"] = { name = "+Icon" },
          ["<leader>in"] = { "<cmd>IconPickerNormal<cr>", "Icon Picker Normal" },
          ["<leader>iy"] = { "<cmd>IconPickerYank<cr>",  "Icon Picker Yank" },
        ''
        else ""
      }



        ${
        if config.vim.languages.markdown.glow.enable
        then ''
          -- Preview
          ["<leader>p"] = { name = "+Preview" },
          ["<leader>pm"] = { "<cmd>Glow<CR>",  "Preview Markdown" },

        ''
        else ""
      }

        ${
        if config.vim.utility.motion.hop.enable
        then ''
          -- Motion
          ["<leader>m"] = { name = "+Motion" },
          ["<leader>mp"] = { "<cmd> HopPattern<CR>", "Hop Pattern" },
        ''
        else ""
      }

        ${
        if config.vim.utility.eyeliner.enable
        then ''
          -- Eyeliner
          ["<leader>e"] = { name = "+Eyeliner" },
          ["<leader>et"] = { "<cmd> EyelinerToggle<CR>", "Toggle Eyeliner" },
        ''
        else ""
      }

        ${
        if config.vim.utility.easyalign.enable
        then ''
          -- Easy Align
          ["<leader>a"] = { name = "+Align" },
          ["<leader>aa"] = { "", "Align" },
          ["<leader>al"] = { "", "Align (Live)" },
        ''
        else ""
      }

        ${
        if config.vim.utility.hardtime.enable
        then ''
          -- Hardtime
          ["<leader>u"] = { name = "+Utilities" },
          ["<leader>uh"] = { "", "Hardtime toggle" },
        ''
        else ""
      }

      })
    '';
  };
}
