{ lib, imputs, config, pkgs, ... }:
let
  custompkgs = (builtins.getFlake "/home/oscilo/.dotfiles").packages.x86_64-linux;
in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  ###Hard_Drives
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/media/crucial" =
    { device = "/dev/sda1";
      fsType = "ext4";
    };

  fileSystems."/media/storage" =
    { device = "/dev/sdb1";
      fsType = "ntfs-3g";
    };

  ###Networking
  boot.extraModulePackages = [ 
    config.boot.kernelPackages.rtl8812au 
  ];
  networking.hostName = "oscilo-pc";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [
     "*" "except:type:wwan" "except:type:gsm"
  ];
  networking.wireless.enable = true;
  networking.wireless.networks = {
    Orange_Swiatlowod_S_EXT = {
      psk = "Bargaw28";
    };
  };
  
  ###Locale
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };
  console.keyMap = "pl2";

  ###Users
  users.users.oscilo = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [
      pkgs.waybar
      pkgs.usbutils
      pkgs.wget
      pkgs.gcc
      pkgs.htop
      pkgs.git
      pkgs.pavucontrol
      pkgs.neofetch
      pkgs.kitty
      pkgs.libsForQt5.okular
      pkgs.discord
      pkgs.firefox
      pkgs.rofi
      pkgs.super-slicer-beta
      pkgs.freecad
      pkgs.xfce.thunar
      pkgs.p7zip
      pkgs.libreoffice-fresh
      pkgs.dropbox 
      pkgs.torrential
      pkgs.lutris
      pkgs.wineWowPackages.waylandFull
      pkgs.spacenavd
      pkgs.paraview
      custompkgs.ondsel-appimage-pre
      custompkgs.openfoam
      pkgs.mpi
    ]; 
  };

  ###Global programs
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

  ###Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ###Display
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.autoLogin.user = "oscilo";
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  
  ###Other
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
