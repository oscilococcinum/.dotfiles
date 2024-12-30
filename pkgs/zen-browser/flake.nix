{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-beta-appimage-x86_64-linux.url = "https://github.com/zen-browser/desktop/releases/download/twilight/zen-x86_64.AppImage";
    zen-beta-appimage-x86_64-linux.flake = false;
    zen-twilight-appimage-x86_64-linux.url = "https://github.com/zen-browser/desktop/releases/download/1.0.2-b.5/zen-x86_64.AppImage";
    zen-twilight-appimage-x86_64-linux.flake = false;

  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map (system:
      {
        name = system;
        value = with import nixpkgs { inherit system; config.allowUnfree = true;}; rec {
          
          zen-beta-appimage = appimageTools.wrapType2 {
            pname = "zen-beta";
            version = "beta";
            src = inputs."zen-beta-appimage-${system}";
            #extraInstallCommands = ''
            #cd ..
            #install -D $PWD/zen-beta.desktop $out/share/applications/zen-beta.desktop
            #'';
          };

          zen-twilight-appimage = appimageTools.wrapType2 {
            pname = "zen-twilight";
            version = "twilight";
            src = inputs."zen-twilight-appimage-${system}";
            #extraInstallCommands = ''
            #cd ..
            #install -D $PWD/zen-twilight.desktop $out/share/applications/zen-twilight.desktop
            #'';
          };
        };
      }
    )[ "x86_64-linux" "aarch64-linux" ]);
  };
}
