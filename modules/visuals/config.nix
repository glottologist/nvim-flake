{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.visuals;
in {
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.indentBlankline.enable {
      vim.startPlugins = ["indent-blankline"];
      vim.luaConfigRC.indent-blankline = nvim.dag.entryAnywhere ''
        -- highlight error: https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
        vim.wo.colorcolumn = "99999"
        vim.opt.list = true

        ${optionalString (cfg.indentBlankline.eolChar != null) ''
          vim.opt.listchars:append({ eol = "${cfg.indentBlankline.eolChar}" })
        ''}
        ${optionalString (cfg.indentBlankline.fillChar != null) ''
          vim.opt.listchars:append({ space = "${cfg.indentBlankline.fillChar}" })
        ''}

        require("indent_blankline").setup {
          enabled = true,
          char = "${cfg.indentBlankline.listChar}",
          show_current_context = ${boolToString cfg.indentBlankline.showCurrContext},
          show_end_of_line = ${boolToString cfg.indentBlankline.showEndOfLine},
          use_treesitter = ${boolToString cfg.indentBlankline.useTreesitter},
        }
      '';
    })

    (mkIf cfg.cursorWordline.enable {
      vim.startPlugins = ["nvim-cursorline"];
      vim.luaConfigRC.cursorline = nvim.dag.entryAnywhere ''
        vim.g.cursorline_timeout = ${toString cfg.cursorWordline.lineTimeout}
      '';
    })

    (mkIf cfg.nvimWebDevicons.enable {
      vim.startPlugins = ["nvim-web-devicons"];
    })

    (mkIf cfg.scrollBar.enable {
      vim.startPlugins = ["scrollbar-nvim"];
      vim.luaConfigRC.scrollBar = nvim.dag.entryAnywhere ''
        require('scrollbar').setup{
            excluded_filetypes = {
              'prompt',
              'TelescopePrompt',
              'noice',
              'NvimTree',
              'alpha',
              'code-action-menu-menu'
            },
          }
      '';
    })

    (mkIf cfg.smoothScroll.enable {
      vim.startPlugins = ["cinnamon-nvim"];
      vim.luaConfigRC.smoothScroll = nvim.dag.entryAnywhere ''
        require('cinnamon').setup()
      '';
    })


    (mkIf cfg.fidget-nvim.enable {
      vim.startPlugins = ["fidget-nvim"];
      vim.luaConfigRC.fidget-nvim = nvim.dag.entryAnywhere ''
        require"fidget".setup{
          align = {
            bottom = ${boolToString cfg.fidget-nvim.align.bottom},
            right = ${boolToString cfg.fidget-nvim.align.right},
          }
        }
      '';
    })
  ]);
}
