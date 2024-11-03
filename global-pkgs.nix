{ pkgs, config, ... }:{

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    
    programs.fish = {
        enable = true;
    };
    
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
    };

    fonts.packages = with pkgs; [
        font-awesome
    ];
}
