{ pkgs, ... }:
let
  zen-browser-nix = (builtins.getFlake "github:oscilococcinum/zen-browser-nix").packages.x86_64-linux;
  freecad-nix = (builtins.getFlake "github:oscilococcinum/freecad-nix").packages.x86_64-linux;
  nix-alien-pkg = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") { };
in {
  users.users.oscilo = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "storage" "networkmanager" "wheel" "video" "dialout" "davfs2" ];
    packages = (with pkgs; [
      git
      lazygit
      libsForQt5.okular
      vesktop
      prusa-slicer
      p7zip
      spacenavd
      paraview
      mpi
      elmerfem
      kdePackages.kdenlive
      python312
    ]) ++ [
      zen-browser-nix.zen-twilight-appimage
      freecad-nix.freecad-appimage
      nix-alien-pkg.nix-alien
    ];
  };
}
