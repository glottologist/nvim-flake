{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.ocaml;

  defaultServer = "ocamllsp";
  servers = {
    ocamllsp = {
      package = pkgs.ocamlPackages.ocaml-lsp;
      lspConfig = ''
        lspconfig.ocamllsp.setup{
          capabilities = capabilities;
          on_attach = default_on_attach;
          cmd = {"${cfg.lsp.package}/bin/ocaml-lsp"}
        }
      '';
    };
  };

  defaultFormat = "ocamlformat";
  formats = {
    ocamlformat = {
      package = pkgs.ocamlformat;
      nullConfig = ''
        table.insert(
          ls_sources,
          null_ls.builtins.formatting.ocamlformat.with({
            command = "${cfg.format.package}/bin/ocamlformat",
          })
        )
      '';
    };
  };
in {
  options.vim.languages.ocaml = {
    enable = mkEnableOption "Ocaml language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Ocaml treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "ocaml";
    };

    lsp = {
      enable = mkOption {
        description = "Enable Ocaml LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "Ocaml LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = mkOption {
        description = "Ocaml LSP server package";
        type = types.package;
        default = servers.${cfg.lsp.server}.package;
      };
    };

    format = {
      enable = mkOption {
        description = "Enable Ocaml formatting";
        type = types.bool;
        default = config.vim.languages.enableFormat;
      };
      type = mkOption {
        description = "Ocaml formatter to use";
        type = with types; enum (attrNames formats);
        default = defaultFormat;
      };
      package = mkOption {
        description = "Ocaml formatter package";
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
      vim.lsp.lspconfig.sources.ocamllsp = servers.${cfg.lsp.server}.lspConfig;
    })

    (mkIf cfg.format.enable {
      vim.lsp.null-ls.enable = true;
      vim.lsp.null-ls.sources.ocamlformat = formats.${cfg.format.type}.nullConfig;
    })
  ]);
}
