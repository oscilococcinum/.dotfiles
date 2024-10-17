{ pkgs, ... }:{
    environment.systemPackages = [
        pkgs.rocmPackages.rocm-smi
    ];
    
    virtualisation.oci-containers = {
        backend = "podman";
        containers = {
            invokeai-rocm = {
                image = "ghcr.io/invoke-ai/invokeai:main-rocm";
                ports = [ "80:9090" ];
		autoStart = true;
                extraOptions = [
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
}
