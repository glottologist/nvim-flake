{
  pkgs,
  lib,
  check ? true,
}: let
  modules = [
    ./basic
    ./core
    ./completion
    ./ai
    ./theme
    ./statusline
    ./tabline
    ./filetree
    ./visuals
    ./lsp
    ./treesitter
    ./autopairs
    ./snippets
    ./git
    ./utility
    ./notes
    ./terminal
    ./ui
    ./comments
    ./languages
  ];

  pkgsModule = {config, ...}: {
    config = {
      _module.args.baseModules = modules;
      _module.args.pkgsPath = lib.mkDefault pkgs.path;
      _module.args.pkgs = lib.mkDefault pkgs;
      _module.check = check;
    };
  };
in
  modules ++ [pkgsModule]
