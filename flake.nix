{
  description = "APRIL - Application Runtime Integration Library";

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "aarch64-linux"
        "i686-linux"
        "riscv64-linux"
        "x86_64-linux"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.stdenv.mkDerivation rec {
            name = "april";
            src = self;
            outputs = [ "out" "dev" ];

            enableParallelBuilding = true;
            nativeBuildInputs = with pkgs; [ meson ninja pkg-config vala ];
            buildInputs = with pkgs; [ glib ];

            meta = with pkgs.lib; {
              homepage = "https://github.com/ExpidusOS/april";
              license = with licenses; [ gpl3Only ];
              maintainers = [ "Tristan Ross" ];
            };
          };
        });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              meson
              ninja
              pkg-config
              vala
              gcc
              glib
            ];
          };
        });
    };
}
