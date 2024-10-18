{ self, config, lib, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "nikradap.ddns.net";
    https = true;
    #home = "/";
    config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}"; #Only for first run. Change pass after run using "nextcloud-occ user:resetpassword root"
    settings.trusted_domains = [ "192.168.1.28" "nikradap.ddns.net" ];
  };
  users.users.nextcloud = {
    extraGroups = [ "storage" "wheel" "nextcloud" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 9980 ];
  
  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    enableACME = true;
  };
  
  security.acme = {
    acceptTerms = true;   
    certs = { 
      ${config.services.nextcloud.hostName}.email = "gawlikbar@gmail.com"; 
    }; 
  };

}
