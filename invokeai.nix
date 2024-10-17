{ pkgs, networking, ... }:{
    environment.systemPackages = [
        pkgs.rocmPackages.rocm-smi
    ];
    
    virtualisation.oci-containers = {
        backend = "podman";
        containers = {
            invokeai-rocm = {
                image = "ghcr.io/invoke-ai/invokeai:main-rocm";
                ports = [ "127.0.0.1:9090:9090" ];
		autoStart = true;
                cmd = [
                    "--device"
		    "/dev/kfd"
                    "--device"
		    "/dev/dri"
                    "--security-opt"
		    "seccomp=unconfined"
                ];
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 9090 ];
    networking.nat = {
      enable = true;
      internalInterfaces = ["podman0"];
      externalInterface = "wlp39s0f3u4";
      enableIPv6 = true;
    };
}
