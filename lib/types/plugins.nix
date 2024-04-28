{lib}:
with lib; let
  # Plugin must be same as input name from flake.nix
  availablePlugins = [
    # TODO: sort by category
    "alpha-nvim"
    "bufdelete-nvim"
    "catppuccin"
    "cheatsheet-nvim"
    "cinnamon-nvim"
    "clojure-lsp"
    "cmp-buffer"
    "cmp-nvim-lsp"
    "cmp-path"
    "cmp-treesitter"
    "cmp-vsnip"
    "colorizer"
    "comment-nvim"
    "copilot-lua"
    "crates-nvim"
    "dashboard-nvim"
    "diffview-nvim"
    "dracula"
    "dressing-nvim"
    "easyalign"
    "elixir-ls"
    "elixir-tools"
    "eyeliner"
    "fidget-nvim"
    "flutter-tools"
    "fsharp-language-server"
    "gitsigns-nvim"
    "git-worktrees"
    "glow-nvim"
    "hop-nvim"
    "hardtime"
    "icon-picker-nvim"
    "indent-blankline"
    "kommentary"
    "leap-nvim"
    "lsp-signature"
    "lsp-format"
    "lspkind"
    "lspsaga"
    "lualine"
    "modes-nvim"
    "noice-nvim"
    "nui-nvim"
    "null-ls"
    "nvim-autopairs"
    "nvim-bufferline-lua"
    "nvim-cmp"
    "nvim-code-action-menu"
    "nvim-compe"
    "nvim-cursorline"
    "nvim-lightbulb"
    "nvim-lspconfig"
    "nvim-notify"
    "nvim-tree-lua"
    "nvim-treesitter"
    "nvim-treesitter-context"
    "nvim-ts-autotag"
    "nvim-web-devicons"
    "obsidian-nvim"
    "onedark"
    "papercolor"
    "plenary-nvim"
    "nui-nvim"
    "rust-tools"
    "scrollbar-nvim"
    "sqls-nvim"
    "tabnine-nvim"
    "tabular"
    "telescope"
    "todo-comments"
    "toggleterm-nvim"
    "tokyonight"
    "trouble"
    "vim-markdown"
    "vim-repeat"
    "vim-vsnip"
    "wakatime"
    "which-key"
    "zenmode"
    "zenbones"
  ];
  # You can either use the name of the plugin or a package.
  pluginsType = with types;
    listOf (
      nullOr (
        either
        (enum availablePlugins)
        package
      )
    );
in {
  pluginsOpt = {
    description,
    default ? [],
  }:
    mkOption {
      inherit description default;
      type = pluginsType;
    };
}
