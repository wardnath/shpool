{
  description = "Shpool - Persistent Shell Session Tool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import rust-overlay) ];
        };
        rust = pkgs.rust-bin.stable.latest.default;
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "shpool";
          version = "0.1.0";

          src = ./.;

          buildInputs = [ rust ];

          cargoSha256 = pkgs.lib.fakeSha256;

          buildPhase = ''
            cargo build --release
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp target/release/shpool $out/bin/
          '';

          meta = with pkgs.lib; {
            description = "Persistent shell session tool";
            license = licenses.mit;
            maintainers = [ maintainers.yourName ];
          };
        };
      });
}
