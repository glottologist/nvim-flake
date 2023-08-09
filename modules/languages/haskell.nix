{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.haskell;

  defaultServer = "hls";
  servers = {
    hls = {
      package = pkgs.haskell-language-server;
      lspConfig = ''
        lspconfig.hls.setup{
          capabilities = capabilities;
          on_attach = default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/haskell-language-server", "--stdio"}
        }
      '';
    };
  };

  defaultFormat = "stylish_haskell";
  formats = {
    stylish_haskell = {
      package = pkgs.haskellPackages.stylish-haskell;
      nullConfig = ''
        table.insert(
          ls_sources,
          null_ls.builtins.formatting.stylish_haskell.with({
            command = "${cfg.format.package}/bin/stylish-haskell",
          })
        )
      '';
    };
  };
in {
  options.vim.languages.haskell = {
    enable = mkEnableOption "Haskell language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Haskell treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "haskell";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Haskell LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "Haskell LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Haskell LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

    format = {
      enable = mkOption {
        description = "Enable Haskell formatting";
        type = types.bool;
        default = config.vim.languages.enableFormat;
      };
      type = mkOption {
        description = "Haskell formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };
      package = mkOption {
        description = "Haskell formatter package";
        type = types.package;
        default = formats.${cfg.format.type}.package;
      };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = [cfg.treesitter.package];
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.hls = servers.${cfg.lsp.server}.lspConfig;
    })

    (mkIf cfg.format.enable {
      vim.lsp.null-ls.enable = true;
      vim.lsp.null-ls.sources.stylish_haskell = formats.${cfg.format.type}.nullConfig;
    })
  ]);
}
