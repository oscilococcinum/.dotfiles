{ lib, imputs, config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  ###Hard_Drives
  boot.supportedFilesystems = [ "ntfs" ];
  
  fileSystems."/media/crucial" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

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

  ###Sound
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
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.user = "oscilo";
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";
}
