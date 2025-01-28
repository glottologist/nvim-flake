{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.bash;

  defaultServer = "bash_language_server";
  servers = {
    bash_language_server = {
      package = pkgs.bash-language-server;
      lspConfig = ''
        lspconfig.bashls.setup {
          capabilities = capabilities;
          on_attach=default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/bash-language-server","start"};
          ${optionalString (cfg.lsp.opts != null) "init_options = ${cfg.lsp.opts}"}
        }
      '';
    };
  };
in {
  options.vim.languages.bash = {
    enable = mkEnableOption "Bash language support";

    treesitter = {
      enable = mkOption {
        description = "Enable bash treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "bash";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Bash LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "The Bash LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Bash LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
      opts = mkOption {
        description = "Options to pass to Bash LSP server";
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

      vim.lsp.lspconfig.sources.bash_language_server = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
