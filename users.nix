{ pkgs, ... }:
let
  custom-nixpkgs = (builtins.getFlake "github:oscilococcinum/custom-nixpkgs").packages.x86_64-linux;
  nix-alien-pkg = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") { };
in {
  users.users.oscilo = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "storage" "networkmanager" "wheel" "video" "dialout" "davfs2" "quemu" ];
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
      quickemu
      spice-gtk
      bluetuith
    ]) ++ [
      custom-nixpkgs.zen-twilight-appimage
      custom-nixpkgs.freecad-weekly-appimage
      custom-nixpkgs.freecadrt-appimage
      nix-alien-pkg.nix-alien
      custom-nixpkgs.OpenHantek6022
    ];
  };
  services.udev.packages = [ custom-nixpkgs.OpenHantek6022 ];
}
