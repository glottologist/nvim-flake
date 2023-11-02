{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.markdown;
in {
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;

      vim.treesitter.grammars = [cfg.treesitter.mdPackage cfg.treesitter.mdInlinePackage];
    })

    (mkIf cfg.glow.enable {
      vim.startPlugins = ["glow-nvim"];

      vim.globals = {
        "glow_binary_path" = "${pkgs.glow}/bin";
      };

      vim.configRC.glow = nvim.dag.entryAnywhere ''
        autocmd FileType markdown noremap <leader>pm :Glow<CR>
        autocmd BufRead,BufNewFile *.markdown,*.md set conceallevel=2 foldlevelstart=6
      '';
    })
  ]);
}
