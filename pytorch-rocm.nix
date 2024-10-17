{ pkgs, ...}:{

virtualisation.oci-containers = {
        backend = "podman";
        containers = {
            pytorch-rocm = {
                image = "rocm/pytorch:latest";
                #ports = [ "80:9090" ];
		autoStart = true;
                extraOptions = [
		    #"-it"
		    "--cap-add=SYS_PTRACE" 
		    "--security-opt" 
		    "seccomp=unconfined" 
		    "--device=/dev/kfd"
		    "--device=/dev/dri"
		    "--group-add" 
		    "video" 
		    "--ipc=host"
		    "--shm-size"
		    "8G" 
		    #"rocm/pytorch:latest"
                ];
            };
        };
    };
}
