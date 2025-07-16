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
        lightbulb.enable = false;
        lspsaga.enable = false;
        nvimCodeActionMenu.enable = false;
        actionsPreview.enable = false;
        trouble.enable = false;
        lspSignature.enable = false;
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
          enable = false; #isDeveloper;
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
        enable = false;
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
        enable = false;
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
        nvimBufferline.enable = false;
      };

      vim.treesitter = {
        enable = true;
        fold = false;
      };

      vim.treesitter.context.enable = false;

      vim.binds = {
        whichKey.enable = false;
        cheatsheet.enable = false;
      };

      vim.telescope.enable = false;

      vim.git = {
        enable = true;
        gitworktrees.enable = false;
        gitsigns.enable = false;
        gitsigns.codeActions = false; # throws an annoying debug message
      };

      vim.notify = {
        nvim-notify = {
          enable = false;
          background_colour = "#F0EDEC";
        };
      };

      vim.utility = {
        eyeliner.enable = false;
        colorizer.enable = false;
        diffview-nvim.enable = false;
        easyalign.enable = false;
        hardtime.enable = false;
        icon-picker.enable = false;
        wakatime.enable = false;
        zenmode.enable = false;
        motion = {
          hop.enable = false;
          leap.enable = false;
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
        noice.enable = false;
      };

      vim.comments = {
        comment-nvim.enable = false;
      };
    };
  };
in {
  inherit neovimConfiguration mainConfig;
}
