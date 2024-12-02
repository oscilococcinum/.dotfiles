{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    freecadrt-appimage-x86_64-linux.url = "https://github.com/realthunder/FreeCAD/releases/download/20241003stable/FreeCAD-Link-Stable-Linux-x86_64-py3.11-20241003.AppImage";
    freecadrt-appimage-x86_64-linux.flake = false;
    freecad-weekly-appimage-x86_64-linux.url = "https://github.com/FreeCAD/FreeCAD-Bundle/releases/download/weekly-builds/FreeCAD_weekly-builds-39380-conda-Linux-x86_64-py311.AppImage";
    freecad-weekly-appimage-x86_64-linux.flake = false;

  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map (system:
      {
        name = system;
        value = with import nixpkgs { inherit system; config.allowUnfree = true;}; rec {
          
          freecadrt-appimage = appimageTools.wrapType2 {
            name = "freecadrt";
            src = inputs."freecadrt-appimage-${system}";
            #extraInstallCommands = ''
            #cd ..
            #install -D $PWD/freecadrt.desktop $out/share/applications/freecadrt.desktop
            #'';
          };

          freecad-weekly-appimage = appimageTools.wrapType2 {
            name = "freecad";
            src = inputs."freecad-weekly-appimage-${system}";
            #extraInstallCommands = ''
            #cd ..
            #install -D $PWD/freecad-weekly.desktop $out/share/applications/freecad-weekly.desktop
            #'';
          };
        };
      }
    )[ "x86_64-linux" "aarch64-linux" ]);
  };
}
