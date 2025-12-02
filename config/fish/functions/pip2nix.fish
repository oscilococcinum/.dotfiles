function pip2nix
    nix run github:nix-community/pip2nix -- generate -r $argv
end
