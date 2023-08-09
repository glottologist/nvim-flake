{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.comments.comment-nvim;
in {
  config = mkIf cfg.enable {
    vim.startPlugins = [
      "comment-nvim"
    ];

    vim.luaConfigRC.comment-nvim = nvim.dag.entryAnywhere ''
        require('Comment').setup(
            {
      opleader = {
          line = 'cl',
          block = 'cb',
      },
      ---LHS of extra mappings
      extra = {
          above = 'cO',
          below = 'co',
          eol = 'cA',
      },
      mappings = {
          basic = true,
          extra = true,
      },
            }
            )
    '';
  };
}
