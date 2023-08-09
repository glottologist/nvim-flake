{lib}:
with lib; let
  # Plugin must be same as input name from flake.nix
  availablePlugins = [
    # TODO: sort by category
    "alpha-nvim"
    "bufdelete-nvim"
    "catppuccin"
    "cellular-automaton"
    "cheatsheet-nvim"
    "cinnamon-nvim"
    "clojure-lsp"
    "cmp-buffer"
    "cmp-nvim-lsp"
    "cmp-path"
    "cmp-treesitter"
    "cmp-vsnip"
    "codewindow-nvim"
    "colorizer"
    "comment-nvim"
    "copilot-lua"
    "crates-nvim"
    "dashboard-nvim"
    "diffview-nvim"
    "dracula"
    "dressing-nvim"
    "elixir-ls"
    "elixir-tools"
    "fidget-nvim"
    "flutter-tools"
    "fsharp-language-server"
    "gitsigns-nvim"
    "glow-nvim"
    "hop-nvim"
    "icon-picker-nvim"
    "indent-blankline"
    "kommentary"
    "leap-nvim"
    "lsp-signature"
    "lspkind"
    "lspsaga"
    "lualine"
    "minimap-vim"
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
    "which-key"
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
