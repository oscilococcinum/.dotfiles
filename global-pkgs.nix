{ pkgs, ... }:
let
  zen-browser-nix = (builtins.getFlake "github:oscilococcinum/zen-browser-nix").packages.x86_64-linux;
  freecad-nix = (builtins.getFlake "github:oscilococcinum/freecad-nix").packages.x86_64-linux;
  nix-alien-pkg = import (builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master") { };
in {
  programs.fish = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.systemPackages = with pkgs; [
    git
    lazygit
    ranger
    libsForQt5.okular
    vesktop
    prusa-slicer
    p7zip
    spacenavd
    paraview
    mpi
    elmerfem
    kdePackages.kdenlive
    grim # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    bemenu
    waybar
    swaybg
    neovim
    pavucontrol
    kitty
    usbutils
    wget
    vlc
    htop
    neofetch
    glaxnimate
    nextcloud-client
    ripgrep
    fzf
  ] ++ [
    zen-browser-nix.zen-twilight-appimage
    freecad-nix.freecad-appimage
    nix-alien-pkg.nix-alien
  ];

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  # Enables autologin for nextcloud-client
  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
  ];
}
