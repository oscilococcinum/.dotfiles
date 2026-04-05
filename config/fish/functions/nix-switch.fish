function nix-switch
    nix flake update
    sudo nixos-rebuild switch --flake ~/.dotfiles/ --impure $argv
end

