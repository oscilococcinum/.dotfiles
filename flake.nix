{
  description = "Ondsel package from AppImage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    ###Place for appimages
    ondsel-appimage-x86_64-linux.url = "https://github.com/Ondsel-Development/FreeCAD/releases/download/2024.2.2/Ondsel_ES_2024.2.2.37240-Linux-x86_64.AppImage";
    ondsel-appimage-x86_64-linux.flake = false;
    ondsel-appimage-aarch64-linux.url = "https://github.com/Ondsel-Development/FreeCAD/releases/download/2024.2.2/Ondsel_ES_2024.2.2.37240-Linux-aarch64.AppImage";
    ondsel-appimage-aarch64-linux.flake = false;
    ondsel-appimage-pre-x86_64-linux.url = "https://github.com/Ondsel-Development/FreeCAD/releases/download/weekly-builds/Ondsel_ES_weekly-builds-38021-Linux-x86_64.AppImage";
    ondsel-appimage-pre-x86_64-linux.flake = false;
    ondsel-appimage-pre-aarch64-linux.url = "https://github.com/Ondsel-Development/FreeCAD/releases/download/weekly-builds/Ondsel_ES_weekly-builds-38021-Linux-aarch64.AppImage";
    ondsel-appimage-pre-aarch64-linux.flake = false;
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map
      (system: {
        name = system;
        value = with import nixpkgs { inherit system; }; rec {
          
	  ###Place for pkgs defined in custompkgs
          ondsel-appimage = appimageTools.wrapType2 {
            name = "ondsel";
            src = inputs."ondsel-appimage-${system}";
          };

          ondsel-appimage-pre = appimageTools.wrapType2 {
            name = "ondsel";
            src = inputs."ondsel-appimage-pre-${system}";
          };

          parmetis-shared = pkgs.callPackage (import ./custompkgs/parmetis-shared) { };
          scotch-shared = pkgs.callPackage (import ./custompkgs/scotch-shared) { };
          openfoam-2306 = pkgs.callPackage (import ./custompkgs/openfoam) { parmetis = parmetis-shared; scotch = scotch-shared; };
          openfoam-2312 = openfoam-2306.override { version = "2312"; hash = "0wgfyz4q7xr0vlv4znfxpxyp8jb53q5pl17k312dyb3x8gkdx2z4"; };
          cfmesh-cfdof = pkgs.callPackage (import ./custompkgs/cfmesh-cfdof) { openfoam = openfoam-2306; };
          hisa = pkgs.callPackage (import ./custompkgs/hisa) { openfoam = openfoam-2306; };
          cfmesh-cfdof-unstable = cfmesh-cfdof.override { version = "unstable"; };
          hisa-unstable = hisa.override { version = "unstable"; };
        };
      }) [ "x86_64-linux" "aarch64-linux" ]);
  };
}
