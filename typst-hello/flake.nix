{
  description = "Simple Hello world for typst";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems =
        fn:
        nixpkgs.lib.genAttrs systems (
          system:
          fn (
            import nixpkgs {
              inherit system;
            }
          )
        );

      build-script =
        {
          writeScriptBin,
          bash,
          typst,
        }:
        writeScriptBin "build-notes" ''
          #!${bash}/bin/bash

          # GREEN='\033[0;32m'
          RED='\033[0;31m'
          NC='\033[0m'

          mkdir -p dist

          find . -name "*.typ" -type f | while read -r file; do
            echo -e "''${GREEN}Building $file...''${NC}"
            
            outdir="dist/$(dirname "$file")"
            mkdir -p "$outdir"
            
            # Compile le fichier
            ${typst}/bin/typst compile "$file" "$outdir/$(basename "$file" .typ).pdf"
            
            if [ $? -eq 0 ]; then
              echo -e "''${GREEN}Successfully built $file''${NC}"
            else
              echo -e "''${RED}Failed to build $file''${NC}"
              exit 1
            fi
          done

          echo -e "''${GREEN}Build complete! PDFs are in the dist directory''${NC}"
        '';
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            typst
            typstfmt
            tinymist
            (pkgs.callPackage build-script { })
          ];
          packages = with pkgs; [
            nil
            nixfmt-rfc-style
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
