{ pkgs, inputs, ... }:
{
  programs.nixvim.enable = true;

  programs.fish = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  environment.systemPackages =
    with pkgs;
    [
      git
      lazygit
      yazi
      vesktop
      prusa-slicer
      p7zip
      spacenavd
      paraview
      mpi
      elmerfem
      kdePackages.kdenlive
      grim # screenshot functionality
      (flameshot.override { enableWlrSupport = true; })
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      cliphist
      clipman
      mako # notification system developed by swaywm maintainer
      bemenu
      waybar
      swaybg
      pavucontrol
      kitty
      usbutils
      wget
      vlc
      htop
      glaxnimate
      nextcloud-client
      ripgrep
      fzf
      killall
      mmex
      inputs.zen-browser-nix.packages.${system}.zen-beta-appimage
      inputs.freecad-nix.packages.${system}.freecad-appimage
    ]
    ++ [
      #inputs.zen-browser-nix.packages.${system}.zen-beta-appimage
      #inputs.freecad-nix.packages.${system}.freecad-appimage
    ];

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  # Enables autologin for nextcloud-client
  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
  ];
}
