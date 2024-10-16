{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      imports = [ inputs.haskell-flake.flakeModule ];
      perSystem =
        {
          self',
          system,
          lib,
          config,
          pkgs,
          ...
        }:
        {
          haskellProjects.default = {

            basePackages = pkgs.haskellPackages;

            packages = {
              scotty.source = "0.22";
            };

            devShell = {
              hlsCheck.enable = false;
            };

            autoWire = [
              "packages"
              "apps"
              "checks"
            ];
          };

          devShells.default = pkgs.mkShell {
            name = "payme devShell";
            inputsFrom = [ config.haskellProjects.default.outputs.devShell ];
            nativeBuildInputs = with pkgs; [
              ghcid
              cabal-install
              zlib.dev
              jq
              haskellPackages.hoogle
              haskellPackages.haskell-language-server
            ];
          };

          packages.default = self'.packages.payme;
          apps.default = self'.apps.payme;

        };
    };
}
