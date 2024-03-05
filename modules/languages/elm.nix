{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.elm;

  defaultServer = "elmls";
  servers = {
    elmls = {
      package = pkgs.elmPackages.elm-language-server;
      lspConfig = ''
        lspconfig.elmls.setup {
          capabilities = capabilities;
          on_attach=default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/elm-language-server"};
          ${optionalString (cfg.lsp.opts != null) "init_options = ${cfg.lsp.opts}"}
        }
      '';
    };
  };
in {
  options.vim.languages.elm = {
    enable = mkEnableOption "Elm language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Elm treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "elm";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Elm LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "The Elm LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Elm LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
      opts = mkOption {
        description = "Options to pass to Elm LSP server";
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

      vim.lsp.lspconfig.sources.elmls = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
