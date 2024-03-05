{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.clojure;

  defaultServer = "clojure_lsp";
  servers = {
    clojure_lsp = {
      package = pkgs.clojure-lsp;
      lspConfig = ''
        lspconfig.clojure_lsp.setup {
          capabilities = capabilities;
          on_attach=default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/clojure-lsp"};
          ${optionalString (cfg.lsp.opts != null) "init_options = ${cfg.lsp.opts}"}
        }
      '';
    };
  };
in {
  options.vim.languages.clojure = {
    enable = mkEnableOption "Clojure language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Clojure treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "clojure";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Clojure LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "The Clojure LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Clojure LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
      opts = mkOption {
        description = "Options to pass to Clojure LSP server";
        type = with types; nullOr str;
        default = null;
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

      vim.lsp.lspconfig.sources.clojure_lsp = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
