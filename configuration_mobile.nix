{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "oscilo"; # Define your hostname.
  networking.networkmanager.enable = true;

  #Autologin
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.autoLogin.user = "oscilo";
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";
 
  # Enable sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  #Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  
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


  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8" ;

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

  users.users.oscilo = {
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" ];
    shell = pkgs.fish;
      packages = with pkgs; [ 
        neovim
        waybar
        bluetuith
        usbutils
        wget
        gcc
        htop
        git
        pavucontrol
        neofetch
        kitty
        libsForQt5.okular
        discord
        firefox
        thunderbird
        fish
        wofi
        super-slicer-beta
        freecad
        xfce.thunar
        p7zip
        libreoffice-fresh
        teams-for-linux
        grive2 
        swww
        nodejs_21
        flameshot
        vscode
    ];
  };

  programs.fish.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  fonts.packages = with pkgs; [
    font-awesome
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    #localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

  nixpkgs.config.allowUnfree = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}
