{ lib, imputs, config, pkgs, ... }:{
    environment.systemPackages = [
        amdgpu-dkms
    ];
    
    virtualisation.oci-containers = {
        backend = "docker";
        containers = {
            invokeai_docker = {
                image = "ghcr.io/invoke-ai/invokeai";
                ports = [ "http://localhost:9090" ];
                #volumes = [
                    #"/root/hackagecompare/packageStatistics.json:/root/hackagecompare/packageStatistics.json"
                #];
                cmd = [
                    "--device /dev/kfd"
                    "--device /dev/dri"
                    "--security-opt seccomp=unconfined"
                ];
            };
        };
    };
}