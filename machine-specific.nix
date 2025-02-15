{ config, pkgs, ... }:
let
  openfoam-nix = (builtins.getFlake "github:oscilococcinum/openfoam-nix").packages.x86_64-linux;
in {
  networking.hostName = "oscilo-pc";

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/media/crucial" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  boot.extraModulePackages = [
    config.boot.kernelPackages.rtl8812au
  ];

  environment.systemPackages = with pkgs; [
    openfoam-nix.openfoam-v2406
  ];

}
