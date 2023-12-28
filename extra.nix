inputs: let
  modulesWithInputs = import ./modules inputs;

  neovimConfiguration = {
    modules ? [],
    pkgs,
    lib ? pkgs.lib,
    check ? true,
    extraSpecialArgs ? {},
  }:
    modulesWithInputs {
      inherit pkgs lib check extraSpecialArgs;
      configuration.imports = modules;
    };

  mainConfig = isDeveloper: {
    config = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 20;
          logFile = "/tmp/nvim.log";
        };
      };

      vim.zenmode.enable = true;
      vim.eyeliner.enable = true;
      vim.easyalign.enable = true;

      vim.lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = true;
        nvimCodeActionMenu.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
      };

      vim.languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        ansible.enable = isDeveloper;
        nix.enable = true;
        html.enable = isDeveloper;
        sql.enable = isDeveloper;
        ligo.enable = isDeveloper;
        clojure.enable = isDeveloper;
        elm.enable = isDeveloper;
        fsharp.enable = isDeveloper;
        markdown = {
        enable = true;
        glow.enable=true;
        };
        haskell.enable = isDeveloper;
        ocaml.enable = isDeveloper;
        nim.enable = isDeveloper;
        rust = {
          enable = isDeveloper;
          crates.enable = true;
        };
        ts.enable = isDeveloper;
        go.enable = isDeveloper;
        zig.enable = isDeveloper;
        python.enable = isDeveloper;
        dart.enable = isDeveloper;
        elixir.enable = isDeveloper;
      };

      vim.visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        scrollBar.enable = true;
        smoothScroll.enable = true;
        fidget-nvim.enable = true;
        indentBlankline = {
          enable = true;
          fillChar = null;
          eolChar = null;
          showCurrContext = true;
        };
        cursorWordline = {
          enable = true;
          lineTimeout = 0;
        };
      };

      vim.statusline = {
        lualine = {
          enable = true;
          theme = "ayu_light";
        };
      };

      vim.theme = {
        enable = true;
        name = "zenbones";
        style = "light";
        transparent = false;
      };
      vim.autopairs.enable = true;

      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      vim.filetree = {
        nvimTreeLua = {
          enable = true;
          renderer = {
            rootFolderLabel = null;
          };
          view = {
            width = 25;
          };
        };
      };

      vim.tabline = {
        nvimBufferline.enable = true;
      };

      vim.treesitter.context.enable = true;

      vim.binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      vim.telescope.enable = true;

      vim.git = {
        enable = true;
        gitworktrees.enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions = false; # throws an annoying debug message
      };

      vim.notify = {
        nvim-notify.enable = true;
      };

      vim.utility = {
        colorizer.enable = true;
        icon-picker.enable = true;
        diffview-nvim.enable = true;
        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };

      vim.notes = {
        obsidian = {
          enable = true;
          dir = "~/Documents/notes/";
        };
        todo-comments.enable = true;
      };

      vim.terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      vim.ui = {
        noice.enable = true;
      };

      vim.comments = {
        comment-nvim.enable = true;
      };
    };
  };
in {
  inherit neovimConfiguration mainConfig;
}
