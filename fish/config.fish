if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias nswitch="sudo nixos-rebuild switch"
set fish_greeting
alias nsh="nix-shell --run fish"
alias cdh="cd ~/"
alias v="nvim ."
