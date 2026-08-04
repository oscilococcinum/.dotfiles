function nix-switch
    nix-collect-garbage
    nix flake update
    sudo nixos-rebuild switch --flake ~/.dotfiles/ --impure $argv
end

