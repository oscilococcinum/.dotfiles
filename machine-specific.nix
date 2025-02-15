{ config, pkgs, ... }:
let
  openhantek-nix = (builtins.getFlake "github:oscilococcinum/openhantek6022-nix").packages.x86_64-linux;
in {
  networking.hostName = "oscilo";

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  environment.systemPackages = with pkgs; [
    openhantek-nix.openhantek6022
    bluetuith
  ];

  services.udev.packages = [ openhantek-nix.openhantek6022 ];
}
