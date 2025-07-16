inputs: let
  modulesWithInputs = import ./modules inputs;

  neovimConfiguration = {
    modules ? [],
    pkgs,
    lib ? pkgs.lib,
    check ? false, # Disable the plugin checks to avoid errors
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
        useSystemClipboard = true;
        debugMode = {
          enable = false;
          level = 20;
          logFile = "/tmp/nvim.log";
        };
      };
      vim.code = {
        leetcode.enable = false;
      };
      vim.ai = {
        code-companion = {
          enable = false;
          adapter = "anthropic";
        };
        windsurf = {
          enable = true;
        };
        claude-code = {
          enable = false;
        };
      };

      vim.lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        nvimCodeActionMenu.enable = false;
        actionsPreview.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
      };

      vim.languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        ansible.enable = isDeveloper;
        bash.enable = isDeveloper;
        nix.enable = true;
        html.enable = isDeveloper;
        sql.enable = isDeveloper;
        solidity.enable = isDeveloper;
        ligo.enable = false;
        clojure.enable = false;
        elm.enable = isDeveloper;
        fsharp.enable = isDeveloper;
        markdown = {
          enable = true;
          glow.enable = true;
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
        dart.enable = false;
        elixir.enable = false;
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
        name = "tokyonight";
        style = "day";
        transparent = false;
      };

      vim.autopairs.enable = false;

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

      vim.treesitter = {
        enable = true;
        fold = true;
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
        nvim-notify = {
          enable = false;
          background_colour = "#F0EDEC";
        };
      };

      vim.utility = {
        eyeliner.enable = true;
        colorizer.enable = true;
        diffview-nvim.enable = true;
        easyalign.enable = true;
        hardtime.enable = false;
        icon-picker.enable = true;
        wakatime.enable = true;
        zenmode.enable = true;
        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };

      vim.notes = {
        obsidian = {
          enable = false;
          dir = "~/development/glottologist/me";
        };
        todo-comments.enable = false;
      };

      vim.terminal = {
        toggleterm = {
          enable = false;
          lazygit.enable = false;
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
