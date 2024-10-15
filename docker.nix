{ lib, imputs, config, pkgs, ... }:{
    virtualisation.docker.enable = true;
    #Warning: Beware that the docker group membership is effectively equivalent to being root! Consider using rootless mode below.
    #users.extraGroups.docker.members = [ "oscilo" ];
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
    virtualisation.docker.daemon.settings = {
        data-root = "/media/crucial/docker_data";
    };
    #Changing Docker Daemon's Other settings example
    #The docker daemon settings are pretty extensive, see also: https://github.com/NixOS/nixpkgs/issues/68349
    #For example, it is extremely likely that you want to turn off the userland-proxy, which is designed for Windoze. 
    #virtualisation.docker.daemon.settings = {
        #userland-proxy = false;
        #experimental = true;
        #metrics-addr = "0.0.0.0:9323";
        #ipv6 = true;
        #fixed-cidr-v6 = "fd00::/80";
    #};
}