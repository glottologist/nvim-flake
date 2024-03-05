{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.fsharp;

  defaultServer = "ionide";
  servers = {

ionide = {
 
      package = pkgs.vimPlugins.Ionide-vim;
      lspConfig = ''
        lspconfig.ionide.setup {
          capabilities = capabilities;
          on_attach=default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/ionide"};
          ${optionalString (cfg.lsp.opts != null) "init_options = ${cfg.lsp.opts}"}
        }
      '';

};
    fsharp_language_server = {
      package = pkgs.fsharp-language-server;
      lspConfig = ''
        lspconfig.fsharp_language_server.setup {
          capabilities = capabilities;
          on_attach=default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/fsharp-language-server"};
          ${optionalString (cfg.lsp.opts != null) "init_options = ${cfg.lsp.opts}"}
        }
      '';
    };
  };
in {
  options.vim.languages.fsharp = {
    enable = mkEnableOption "FSharp language support";

    lsp = {
      enable = mkOption {
        description = "Enable FSharp LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "The FSharp LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "FSharp LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
      opts = mkOption {
        description = "Options to pass to FSharp LSP server";
        type = with types; nullOr str;
        default = null;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.ionide = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
