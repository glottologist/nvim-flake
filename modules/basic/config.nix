{
  lib,
  config,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim;
in {
  config = {
    vim.startPlugins = ["plenary-nvim"];

    vim.nmap = mkIf cfg.disableArrows {
      "<up>" = "<nop>";
      "<down>" = "<nop>";
      "<left>" = "<nop>";
      "<right>" = "<nop>";
    };

    vim.imap = mkIf cfg.disableArrows {
      "<up>" = "<nop>";
      "<down>" = "<nop>";
      "<left>" = "<nop>";
      "<right>" = "<nop>";
    };

    vim.nnoremap =
      mkIf cfg.mapLeaderSpace {
        "<space>" = "<nop>";
      }
      // mkIf cfg.useMetaForMovement {
        "<M-h>" = "<C-w>h";
        "<M-j>" = "<C-w>j";
        "<M-k>" = "<C-w>k";
        "<M-l>" = "<C-w>l";
        "<M-H>" = "<C-w>H";
        "<M-J>" = "<C-w>J";
        "<M-K>" = "<C-w>K";
        "<M-L>" = "<C-w>L";
        "<M-x>" = "<C-w>x";
        "<M-=>" = "<C-w>=";
        "<M-+>" = "<C-w>+";
        "<M-->" = "<C-w>-";
        "<M-<>" = "<C-w><";
        "<M->>" = "<C-w>>";
      };

    vim.configRC.basic = nvim.dag.entryAfter ["globalsScript"] ''
      " Debug mode settings
      ${optionalString cfg.debugMode.enable ''
        set verbose=${toString cfg.debugMode.level}
        set verbosefile=${cfg.debugMode.logFile}
      ''}

      " Settings that are set for everything
      set encoding=utf-8
      set mouse=${cfg.mouseSupport}
      set tabstop=${toString cfg.tabWidth}
      set shiftwidth=${toString cfg.tabWidth}
      set softtabstop=${toString cfg.tabWidth}
      set expandtab
      set cmdheight=${toString cfg.cmdHeight}
      set updatetime=${toString cfg.updateTime}
      set shortmess+=c
      set tm=${toString cfg.mapTimeout}
      set hidden
      ${optionalString cfg.splitBelow ''
        set splitbelow
      ''}
      ${optionalString cfg.splitRight ''
        set splitright
      ''}
      ${optionalString cfg.showSignColumn ''
        set signcolumn=yes
      ''}
      ${optionalString cfg.autoIndent ''
        set autoindent
      ''}

      ${optionalString cfg.preventJunkFiles ''
        set noswapfile
        set nobackup
        set nowritebackup
      ''}
      ${optionalString (cfg.bell == "none") ''
        set noerrorbells
        set novisualbell
      ''}
      ${optionalString (cfg.bell == "on") ''
        set novisualbell
      ''}
      ${optionalString (cfg.bell == "visual") ''
        set noerrorbells
      ''}
      ${optionalString (cfg.lineNumberMode == "relative") ''
        set relativenumber
      ''}
      ${optionalString (cfg.lineNumberMode == "number") ''
        set number
      ''}
      ${optionalString (cfg.lineNumberMode == "relNumber") ''
        set number relativenumber
      ''}
      ${optionalString cfg.useSystemClipboard ''
        set clipboard+=unnamedplus
      ''}
      ${optionalString cfg.mapLeaderSpace ''
        let mapleader=" "
        let maplocalleader=" "
      ''}
      ${optionalString cfg.syntaxHighlighting ''
        syntax on
      ''}
      ${optionalString (!cfg.wordWrap) ''
        set nowrap
      ''}
      ${optionalString cfg.hideSearchHighlight ''
        set nohlsearch
        set incsearch
      ''}
      ${optionalString cfg.colourTerm ''
        set termguicolors
        set t_Co=256
      ''}
      ${optionalString (!cfg.enableEditorconfig) ''
        let g:editorconfig = v:false
      ''}
    '';
  };
}
