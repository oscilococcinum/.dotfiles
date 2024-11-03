{ pkgs, ... }:
let
    nix-alien-pkgs = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") { };
    openfoam-pkg = (builtins.getFlake (toString ./pkgs/openfoam)).packages.x86_64-linux;
    freecad-pkg = (builtins.getFlake (toString ./pkgs/freecad)).packages.x86_64-linux;
    zen-browser = (builtins.getFlake (toString ./pkgs/zen-browser)).packages.x86_64-linux;
in {
    users.users.oscilo = {
        shell = pkgs.fish;
        isNormalUser = true;
        description = "oscilo";
        extraGroups = [ "storage" "networkmanager" "wheel" "video" "dialout" "davfs2" ];
        packages = [
            pkgs.waybar
            pkgs.usbutils
            pkgs.wget
            pkgs.gcc
            pkgs.htop
            pkgs.git
            pkgs.neovim
            pkgs.lazygit
            pkgs.pavucontrol
            pkgs.neofetch
            pkgs.kitty
            pkgs.libsForQt5.okular
            pkgs.vesktop
            zen-browser.default
            pkgs.rofi
            pkgs.prusa-slicer
            pkgs.xfce.thunar
            pkgs.p7zip
            pkgs.spacenavd
            pkgs.paraview
            freecad-pkg.freecadrt-appimage
            freecad-pkg.freecad-weekly-appimage
            openfoam-pkg.openfoam
            pkgs.mpi
            pkgs.elmerfem
            nix-alien-pkgs.nix-alien
            pkgs.kdePackages.kdenlive
            pkgs.glaxnimate
            pkgs.vlc
            pkgs.nextcloud-client
            pkgs.tree
            pkgs.python312
        ]; 
    };
}
