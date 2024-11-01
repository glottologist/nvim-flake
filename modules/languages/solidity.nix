{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.solidity;
in {
  options.vim.languages.solidity = {
    enable = mkEnableOption "Solidity language support";

    treesitter = {
      enable = mkOption {
        description = "Enable Solidity treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.types.mkGrammarOption pkgs "solidity";
    };
    lsp = {
      enable = mkOption {
        description = "Solidity LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
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
      vim.lsp.lspconfig.sources.vim-solidity = ''
        lspconfig.solidity.setup {
          capabilities = capabilities,
          on_attach=default_on_attach,
          }
      '';
    })
  ]);
}
