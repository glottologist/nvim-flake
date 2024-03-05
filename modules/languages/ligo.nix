{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.ligo;

  defaultServer = "ligolsp";
  servers = {
    ligolsp = {
      package = pkgs.ligo;
      lspConfig = ''
        lspconfig.ligo.setup{
          capabilities = capabilities;
          on_attach = default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/ligo", "lsp"}
        }
      '';
    };
  };
in {
  options.vim.languages.ligo = {
    enable = mkEnableOption "Ligo language support";

    lsp = {
      enable = mkOption {
        description = "Enable Ligo LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "Ligo LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Ligo LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.ligolsp = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
