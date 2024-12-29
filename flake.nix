{
  description = "monologiques' flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems =
        fn:
        (nixpkgs.lib.genAttrs systems (
          system:
          fn (
            import nixpkgs {
              inherit system;
            }
          )
        ));
    in
    {
      templates = {
        c-hello = {
          path = ./c-hello;
          description = "Simple Hello world in C";
        };

        flake-hello = {
          path = ./flake-hello;
          description = "Simple flake boilter plate";
        };

        rust-hello = {
          path = ./rust-hello;
          description = "Simple Hello world in Rust";
        };
      };

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            nixfmt-rfc-style
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
