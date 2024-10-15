{ lib, imputs, config, pkgs, ... }:{
    virtualisation.oci-containers = {
        backend = "docker";
        containers = {
            invokeai_docker = {
                image = "ghcr.io/invoke-ai/invokeai";
                ports = [ "http://localhost:9090" ];
                #volumes = [
                    #"/root/hackagecompare/packageStatistics.json:/root/hackagecompare/packageStatistics.json"
                #];
                #cmd = [
                #    "--base-url"
                #    "\"/hackagecompare\""
                #];
            };
        };
    };
}