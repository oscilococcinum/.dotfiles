{ lib, imputs, config, pkgs, ... }:{
  users.users.oscilo = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "oscilo";
    extraGroups = [ "storage" "networkmanager" "wheel" "video" "dialout" ];
    packages = [
      pkgs.usbutils
      pkgs.wget
      pkgs.gcc
      pkgs.htop
      pkgs.git
      pkgs.lazygit
      pkgs.neofetch
      pkgs.p7zip
    ]; 
  };
}
