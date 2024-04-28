{
  description = "A neovim flake with a modular configuration";
  outputs = {
    nixpkgs,
    flake-parts,
    self,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        # add lib to module args
        {_module.args = {inherit (nixpkgs) lib;};}
        ./flake/apps.nix
        ./flake/legacyPackages.nix
        ./flake/overlays.nix
        ./flake/packages.nix
      ];

      flake = {
        lib = {
          inherit (import ./lib/stdlib-extended.nix nixpkgs.lib) nvim;
          inherit (import ./extra.nix inputs) neovimConfiguration;
        };

        homeManagerModules = {
          neovim-flake = {
            imports = [
              (import ./lib/module self.packages)
            ];
          };

          default = self.homeManagerModules.neovim-flake;
        };
      };

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells.default = pkgs.mkShell {nativeBuildInputs = [config.packages.editor];};
      };
    };

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";

    # TODO: get zig from the zig overlay instead of nixpkgs
    zig.url = "github:mitchellh/zig-overlay";

    # ZenMode
    zenmode = {
      url = "github:folke/zen-mode.nvim";
      flake = false;
    };
    # Eyeliner
    eyeliner = {
      url = "github:jinh0/eyeliner.nvim";
      flake = false;
    };

    # LSP plugins
    nvim-lspconfig = {
      # url = "github:neovim/nvim-lspconfig?ref=v0.1.3";
      # Use master for nil_ls
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    lsp-format = {
      url = "github:lukas-reineke/lsp-format.nvim";
      flake = false;
    };

    lspsaga = {
      url = "github:tami5/lspsaga.nvim";
      flake = false;
    };

    lspkind = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };

    trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };

    nvim-treesitter-context = {
      url = "github:nvim-treesitter/nvim-treesitter-context";
      flake = false;
    };

    nvim-lightbulb = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };

    git-worktrees = {
      url = "github:ThePrimeagen/git-worktree.nvim";
      flake = false;
    };

    nvim-code-action-menu = {
      url = "github:weilbith/nvim-code-action-menu";
      flake = false;
    };

    lsp-signature = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };

    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };

    sqls-nvim = {
      url = "github:nanotee/sqls.nvim";
      flake = false;
    };

    rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };

    flutter-tools = {
      url = "github:akinsho/flutter-tools.nvim";
      flake = false;
    };

    clojure-lsp = {
      url = "github:clojure-lsp/clojure-lsp";
      flake = false;
    };

    elixir-ls = {
      url = "github:elixir-lsp/elixir-ls";
      flake = false;
    };

    elixir-tools = {
      url = "github:elixir-tools/elixir-tools.nvim";
      flake = false;
    };

    fsharp-language-server = {
      url = "github:faldor20/fsharp-language-server";
      flake = false;
    };

    # Copying/Registers
    registers = {
      url = "github:tversteeg/registers.nvim";
      flake = false;
    };
    nvim-neoclip = {
      url = "github:AckslD/nvim-neoclip.lua";
      flake = false;
    };

    # Telescope
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };

    # Langauge server (use master instead of nixpkgs)
    rnix-lsp.url = "github:nix-community/rnix-lsp";
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Filetrees
    nvim-tree-lua = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };

    # Tablines
    nvim-bufferline-lua = {
      url = "github:akinsho/nvim-bufferline.lua?ref=v3.0.1";
      flake = false;
    };

    # Statuslines
    lualine = {
      url = "github:hoob3rt/lualine.nvim";
      flake = false;
    };

    ## Autocompletes
    nvim-compe = {
      url = "github:hrsh7th/nvim-compe";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-vsnip = {
      url = "github:hrsh7th/cmp-vsnip";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-treesitter = {
      url = "github:ray-x/cmp-treesitter";
      flake = false;
    };

    # snippets
    vim-vsnip = {
      url = "github:hrsh7th/vim-vsnip";
      flake = false;
    };

    # Autopairs
    nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    nvim-ts-autotag = {
      url = "github:windwp/nvim-ts-autotag";
      flake = false;
    };

    # Commenting
    kommentary = {
      url = "github:b3nj5m1n/kommentary";
      flake = false;
    };
    comment-nvim = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };

    todo-comments = {
      url = "github:folke/todo-comments.nvim";
      flake = false;
    };

    # Buffer tools
    bufdelete-nvim = {
      url = "github:famiu/bufdelete.nvim";
      flake = false;
    };

    # Dashboard Utilities
    dashboard-nvim = {
      url = "github:glepnir/dashboard-nvim";
      flake = false;
    };

    alpha-nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };

    vim-startify = {
      url = "github:mhinz/vim-startify";
      flake = false;
    };

    # Themes
    tokyonight = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };

    onedark = {
      url = "github:navarasu/onedark.nvim";
      flake = false;
    };

    catppuccin = {
      url = "github:catppuccin/nvim";
      flake = false;
    };

    dracula = {
      url = "github:Mofiqul/dracula.nvim";
      flake = false;
    };

    # Rust crates
    crates-nvim = {
      url = "github:Saecki/crates.nvim";
      flake = false;
    };

    zenbones = {
      url = "github:mcchrish/zenbones.nvim";
      flake = false;
    };

    papercolor = {
      url = "github:vim-scripts/PaperColor.vim";
      flake = false;
    };

    # Visuals
    nvim-cursorline = {
      url = "github:yamatsum/nvim-cursorline";
      flake = false;
    };

    scrollbar-nvim = {
      url = "github:petertriho/nvim-scrollbar";
      flake = false;
    };

    cinnamon-nvim = {
      url = "github:declancm/cinnamon.nvim";
      flake = false;
    };

    indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };

    fidget-nvim = {
      url = "github:j-hui/fidget.nvim";
      flake = false;
    };

    # Markdown
    glow-nvim = {
      url = "github:ellisonleao/glow.nvim";
      flake = false;
    };

    # Notifications
    nvim-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };

    # Utilities
    colorizer = {
      url = "github:uga-rosa/ccc.nvim";
      flake = false;
    };

    diffview-nvim = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };

    icon-picker-nvim = {
      url = "github:ziontee113/icon-picker.nvim";
      flake = false;
    };

    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    easyalign = {
      url = "github:junegunn/vim-easy-align";
      flake = false;
    };

    hardtime = {
      url = "github:m4xshen/hardtime.nvim";
      flake = false;
    };

    keylog-nvim = {
      url = "github:glottologist/keylog.nvim/b75c21f9307f5070311dc295ac202c51d3bc1d4e";
      flake = false;
    };
    cheatsheet-nvim = {
      url = "github:sudormrfbin/cheatsheet.nvim";
      flake = false;
    };

    gesture-nvim = {
      url = "github:notomo/gesture.nvim";
      flake = false;
    };

    hop-nvim = {
      url = "github:phaazon/hop.nvim";
      flake = false;
    };

    leap-nvim = {
      url = "github:ggandor/leap.nvim";
      flake = false;
    };

    smartcolumn = {
      url = "github:m4xshen/smartcolumn.nvim";
      flake = false;
    };

    # Note-taking
    obsidian-nvim = {
      url = "github:epwalsh/obsidian.nvim";
      flake = false;
    };

    # Terminal
    toggleterm-nvim = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };

    # UI
    noice-nvim = {
      url = "github:folke/noice.nvim";
      flake = false;
    };

    modes-nvim = {
      url = "github:mvllow/modes.nvim";
      flake = false;
    };

    # Assistant
    copilot-lua = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };

    # Dependencies

    plenary-nvim = {
      # (required by crates-nvim)
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };

    dressing-nvim = {
      # (required by icon-picker-nvim)
      url = "github:stevearc/dressing.nvim";
      flake = false;
    };

    vim-markdown = {
      # (required by obsidian-nvim)
      url = "github:preservim/vim-markdown";
      flake = false;
    };

    tabular = {
      # (required by vim-markdown)
      url = "github:godlygeek/tabular";
      flake = false;
    };

    nui-nvim = {
      # (required by noice.nvim and hardtime)
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };

    vim-repeat = {
      url = "github:tpope/vim-repeat";
      flake = false;
    };

    wakatime = {
      url = "github:wakatime/vim-wakatime";
      flake = false;
    };
  };
}
