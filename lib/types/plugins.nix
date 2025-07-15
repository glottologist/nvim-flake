{lib}:
with lib; let
  # Plugin must be same as input name from flake.nix
  availablePlugins = [
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
    "crates-nvim"
    "diffview-nvim"
    "leet-code-nvim"
    "dracula"
    "dressing-nvim"
    "easyalign"
    "elixir-ls"
    "elixir-tools"
    "eyeliner"
    "fidget-nvim"
    "flutter-tools"
    "fsharp-language-server"
    "git-worktrees"
    "gitsigns-nvim"
    "glow-nvim"
    "hardtime"
    "hop-nvim"
    "icon-picker-nvim"
    "indent-blankline"
    "leap-nvim"
    "lsp-format"
    "lsp-signature"
    "lspkind"
    "lspsaga"
    "lualine"
    "modes-nvim"
    "code-companion-nvim"
    "claude-code-nvim"
    "noice-nvim"
    "nui-nvim"
    "null-ls"
    "nvim-autopairs"
    "nvim-bufferline-lua"
    "nvim-cmp"
    "nvim-code-action-menu"
    "actions-preview-nvim"
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
    "tabular"
    "telescope"
    "todo-comments"
    "toggleterm-nvim"
    "tokyonight"
    "trouble"
    "vim-markdown"
    "vim-solidity"
    "vim-repeat"
    "vim-vsnip"
    "wakatime"
    "windsurf"
    "which-key"
    "zenbones"
    "zenmode"
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
