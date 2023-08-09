{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.nim;

  defaultServer = "nimlsp";
  servers = {
    nimlsp = {
      package = pkgs.nimlsp;
      lspConfig = ''
        lspconfig.nimlsp.setup{
          capabilities = capabilities;
          on_attach = default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/nimlsp", "--stdio"}
        }
      '';
    };
  };

in {
  options.vim.languages.nim = {
    enable = mkEnableOption "Nim language support";

    lsp = {
      enable = mkOption {
        description = "Enable Nim LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "Nim LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Nim LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

  };
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.nimlsp = servers.${cfg.lsp.server}.lspConfig;
    })

  ]);
}
