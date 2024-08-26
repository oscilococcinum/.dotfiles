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

  ###Networking
  boot.extraModulePackages = [ 
    config.boot.kernelPackages.rtl8812au 
  ];
  networking.hostName = "oscilo";
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
  i18n.defaultLocale = "pl_PL.UTF-8";
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

  ###Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  
  ###Energy
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
	
	DEVICES_TO_ENABLE_ON_AC="bluetooth wifi wwan";
	DEVICES_TO_ENABLE_ON_BAT="bluetooth wifi wwan";
	DEVICES_TO_DISABLE_ON_BAT="";
	DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="";
	DEVICES_TO_ENABLE_ON_STARTUP="bluetooth wifi wwan";
	RUNTIME_PM_ON_AC="on";
        RUNTIME_PM_ON_BAT="on";
      };
  };
}
