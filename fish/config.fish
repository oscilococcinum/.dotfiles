if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias nixswitch="sudo nixos-rebuild switch"
alias nixconf="nvim /etc/nixos/configuration.nix"
set fish_greeting
alias nixsh="nix-shell --run fish"
alias cdh="cd ~/"
alias v="nvim ."
