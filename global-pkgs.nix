{ pkgs, ... }:{
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
    grim # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    bemenu
    waybar
    swaybg
    neovim
    pavucontrol
    kitty
    xfce.thunar
    usbutils
    wget
    vlc
    htop
    neofetch
    glaxnimate
    nextcloud-client
    ripgrep
  ];

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  # Enables autologin for nextcloud-client
  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
  ];
}
