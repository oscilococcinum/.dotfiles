function nswitch
    sudo nixos-rebuild switch --flake ~/.dotfiles/ --impure $argv
end

