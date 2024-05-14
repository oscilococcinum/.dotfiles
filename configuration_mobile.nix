{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "oscilo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "pl";
  #  xkbVariant = "";
  #};

  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.oscilo = {
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" ];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
      ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
 
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
 
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

  ##Bluetooth
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


  fonts.packages = with pkgs; [
    font-awesome
  ];

  ###Home manager
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  home-manager.users.oscilo = { pkgs, ... }: { 
    home.stateVersion = "23.11";
    nixpkgs.config.allowUnfree = true;
    home.enableNixpkgsReleaseCheck = false;
    home.packages = with pkgs; [ 
      hyprland
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
      rofi
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

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    
    ###Configs 
    home.file.".config/hypr" = {
      source = /home/oscilo/.dotfiles/hypr;
      recursive = true;
    };
 
    ###Kitty config
    home.file.".config/kitty/kitty.conf" = {
      source = /home/oscilo/.dotfiles/kitty/kitty.conf;
    };

    ###Fish config
    home.file.".config/omf" = { 
      source = /home/oscilo/.dotfiles/omf;
      recursive = true;
    };

    home.file.".config/fish" = { 
      source = /home/oscilo/.dotfiles/fish;
      recursive = true;
    };
  };
}
