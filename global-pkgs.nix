{ lib, imputs, config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        " here your custom configuration goes!
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [ fugitive ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  programs.fish = {
    enable = true;
  };
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  fonts.packages = with pkgs; [
    font-awesome
  ];
}
