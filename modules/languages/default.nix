{lib, ...}:
with lib; let
  mkEnable = desc:
    mkOption {
      description = "Turn on ${desc} for enabled languages by default";
      type = types.bool;
      default = false;
    };
in {
  imports = [
    ./ansible.nix
    ./clojure.nix
    ./dart
    ./elixir
    ./elm.nix
    ./fsharp.nix
    ./go.nix
    ./haskell.nix
    ./html.nix
    ./ligo.nix
    ./markdown
    ./nim.nix
    ./nix.nix
    ./ocaml.nix
    ./python.nix
    ./rust.nix
    ./scala.nix
    ./sql.nix
    ./ts.nix
    ./zig.nix
  ];

  options.vim.languages = {
    enableLSP = mkEnable "LSP";
    enableTreesitter = mkEnable "treesitter";
    enableFormat = mkEnable "formatting";
    enableExtraDiagnostics = mkEnable "extra diagnostics";
  };
}
