{ lib, imputs, config, pkgs, ... }:

let
  nix-alien-pkgs = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") { };
  ondsel-pkg = (builtins.getFlake "github:oscilococcinum/ondsel-nix").packages.x86_64-linux;
  zen-browser = (builtins.getFlake "github:oscilococcinum/zen-browser-flake").packages.x86_64-linux;

in {
  users.users.oscilo = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "storage" "networkmanager" "wheel" "video" "dialout" ];
    packages = [
      pkgs.waybar
      pkgs.usbutils
      pkgs.wget
      pkgs.gcc
      pkgs.htop
      pkgs.git
      pkgs.lazygit
      pkgs.pavucontrol
      pkgs.neofetch
      pkgs.kitty
      pkgs.libsForQt5.okular
      pkgs.vesktop
      pkgs.firefox
      zen-browser.default
      pkgs.rofi
      pkgs.prusa-slicer
      pkgs.xfce.thunar
      pkgs.p7zip
      pkgs.spacenavd
      pkgs.paraview
      ondsel-pkg.ondsel-appimage-pre
      nix-alien-pkgs.nix-alien
      pkgs.nextcloud-client
      pkgs.tree
    ]; 
  };
}
