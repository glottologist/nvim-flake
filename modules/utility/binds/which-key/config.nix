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
        }
      })

      wk.register({

        ${
        if config.vim.tabline.nvimBufferline.enable
        then ''
          -- Buffer
          ["<leader>b"] = { name = "+Buffer" },
          ["<leader>bm"] = { name = "+Move" },
          ["<leader>bmn"] = { name = "next" },
          ["<leader>bmp"] = { name = "previous" },
          ["<leader>bm1"] = { name = "1" },
          ["<leader>bm2"] = { name = "2" },
          ["<leader>bm3"] = { name = "3" },
          ["<leader>bm4"] = { name = "4" },
          ["<leader>bm5"] = { name = "5" },
          ["<leader>bm6"] = { name = "6" },
          ["<leader>bm7"] = { name = "7" },
          ["<leader>bm8"] = { name = "8" },
          ["<leader>bm9"] = { name = "9" },
          ["<leader>bc"] = { name = "+Cycle" },
          ["<leader>bcn"] = { name = "next" },
          ["<leader>bcp"] = { name = "previous" },
          ["<leader>bp"] = { name = "pick" },
          ["<leader>bs"] = { name = "Sort" },
          ["<leader>bse"] = { name = "by extension" },
          ["<leader>bsd"] = { name = "by directory" },
          ["<leader>bsi"] = { name = "by id" },
        ''
        else ""
      }

        ${
        if config.vim.telescope.enable
        then ''
          ["<leader>f"] = { name = "+Find" },
           -- Telescope
          ["<leader>ff"] = { name = "files" },
          ["<leader>fp"] = { name = "grep" },
          ["<leader>fb"] = { name = "buffers" },
          ["<leader>fh"] = { name = "help tags" },
          ["<leader>ft"] = { name = "telescope" },
          ["<leader>fg"] = { name = "+Git" },
          ["<leader>fgc"] = { name = "commits" },
          ["<leader>fgb"] = { name = "branches" },
          ["<leader>fgf"] = { name = "buffer commits" },
          ["<leader>fgs"] = { name = "status" },
          ["<leader>fgh"] = { name = "stash" },
        ''
        else ""
      }

        ${
        if config.vim.telescope.enable && config.vim.lsp.enable
        then ''
          ["<leader>fl"] = { name = "+LSP" },
          ["<leader>flr"] = { name = "references" },
          ["<leader>fli"] = { name = "implementations" },
          ["<leader>fld"] = { name = "definitions" },
          ["<leader>flt"] = { name = "type definitions" },
          ["<leader>flg"] = { name = "diagnostics" },
          ["<leader>fls"] = { name = "+Symbols" },
          ["<leader>flsd"] = { name = "document" },
          ["<leader>flsw"] = { name = "workspace" },
        ''
        else ""
      }

        ${
        if config.vim.treesitter.enable
        then ''
          ["<leader>fs"] = { name = "treesitter" },
          ''
        else ""
        }





      ${
        if config.vim.lsp.enable
        then ''
          ["<leader>l"] = { name = "+Language" },
          ["<leader>lg"] = { name = "+Goto" },
          ["<leader>lw"] = { name = "+Workspace" },
          ["<leader>lh"] = { name = "hover" },
          ["<leader>ls"] = { name = "signature" },
          ["<leader>lr"] = { name = "rename" },
        ''
        else ""
      }

        ${
        if config.vim.lsp.trouble.enable
        then ''
          -- Trouble
          ["<leader>ld"] = { name = "+Diagnostics" },
          ["<leader>ldt"] =  { "TroubleToggle" };
          ["<leader>ldw"] = { "TroubleToggle workspace_diagnostics" };
          ["<leader>ldd"] = { "TroubleToggle document_diagnostics" };
          ["<leader>ldr"] = { "TroubleToggle lsp_references" };
          ["<leader>ldq"] = { "TroubleToggle quickfix" };
          ["<leader>ldl"] = { "TroubleToggle loclist" };
        ''
        else ""
      }

      ${
        if config.vim.lsp.lspsaga.enable
        then ''
          ["<leader>lf"] = { name = "find" },
          ["<leader>lh"] = { name = "hover" },
          ["<leader>lr"] = { name = "rename" },
          ["<leader>lp"] = { name = "+Preview" },
          ["<leader>lpd"] = { name = "preview definition" },
          ["<leader>ldl"] = { name = "show line diagnostics" },
          ["<leader>ldc"] = { name = "show cursor diagnostics" },
          ["<leader>ldp"] = { name = "jump to diagnostic (previous)" },
          ["<leader>ldn"] = { name = "jump to diagnostic (next)" },
        ''
        else ""
      }
      ${
        if config.vim.lsp.nvimCodeActionMenu.enable
        then ''
          ["<leader>lc"] = { name = "+Code Action" },
          ["<leader>lca"] = { name = "code action" },
        ''
        else ""
      }
      ${
        if config.vim.lsp.lspSignature.enable
        then ''
          ["<leader>ls"] = { name = "signature help`" },
        ''
        else ""
      }



        ${
        if config.vim.minimap.codewindow.enable || config.vim.minimap.minimap-vim.enable
        then ''
          -- Minimap
          ["<leader>m"] = { name = "+Minimap" }, -- TODO: remap both minimap plugins' keys to be the same
        ''
        else ""
      }


        ${
        if config.vim.filetree.nvimTreeLua.enable
        then ''
          -- NvimTree
          ["<leader>t"] = { name = "+Tree" },
        ''
        else ""
      }

        ${
        if config.vim.git.gitsigns.enable
        then ''
          -- Git
          ["<leader>g"] = { name = "+Git" },
          ["<leader>gl"] = { name = "blame line" },
          ["<leader>gh"] = { name = "+Hunk" },
          ["<leader>ghn"] = { name = "next" },
          ["<leader>ghp"] = { name = "previous" },
          ["<leader>ghs"] = { name = "stage" },
          ["<leader>ghu"] = { name = "undo stage" },
          ["<leader>ghr"] = { name = "reset" },
          ["<leader>ghv"] = { name = "preview" },
          ["<leader>gb"] = { name = "+Buffer" },
          ["<leader>gbr"] = { name = "reset" },
          ["<leader>gbs"] = { name = "stage" },
          ["<leader>gbi"] = { name = "reset index" },
          ["<leader>gt"] = { name = "+Toggle" },
          ["<leader>gts"] = { name = "signs" },
          ["<leader>gtn"] = { name = "numhl" },
          ["<leader>gtl"] = { name = "linehl" },
          ["<leader>gtw"] = { name = "word diff" },
        ''
        else ""
      }


        ${
        if config.vim.terminal.toggleterm.enable
        then ''
          -- Terminal
          ["<leader>k"] = { name = "+Terminal" },
          ["<leader>kt"] = { name = "toggle" },
        ''
        else ""
      }

        ${
        if config.vim.utility.icon-picker.enable
        then ''
          -- Icon Picker
          ["<leader>i"] = { name = "+Icon" },
          ["<leader>in"] = { name = "normal" },
          ["<leader>iy"] = { name = "yank" },
        ''
        else ""
      }



        ${
        if config.vim.languages.markdown.glow.enable
        then ''
          -- Markdown
          ["<leader>pm"] = { name = "+Preview Markdown" },
        ''
        else ""
      }

      })
    '';
  };
}
