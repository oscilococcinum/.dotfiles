{ config, ... }:{
    environment.variables.EDITOR = "neovim";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.11";
}
