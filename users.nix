{ pkgs, ... }:
let
  nix-alien-pkg = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") { };
  openfoam-pkg = (builtins.getFlake (toString ./pkgs/openfoam)).packages.x86_64-linux;
  freecad-pkg = (builtins.getFlake (toString ./pkgs/freecad)).packages.x86_64-linux;
  zen-browser-pkg = (builtins.getFlake (toString ./pkgs/zen-browser)).packages.x86_64-linux;
  quickemu-pkg = (builtins.getFlake "https://github.com/quickemu-project/quickemu.git").packages.x86_64-linux;
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
    ]) ++ [
      openfoam-pkg.openfoam
      nix-alien-pkg.nix-alien
      freecad-pkg.freecad-weekly-appimage
      freecad-pkg.freecadrt-appimage
      zen-browser-pkg.specific
    ];
  };
}
