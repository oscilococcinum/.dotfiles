if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
alias nswitch="sudo nixos-rebuild switch"
alias nsh="nix-shell --run fish"
alias cdh="cd ~/"
alias v="nvim ."
alias ll="ls -l"
alias l="ls -la"
alias nconf="nvim ~/.dotfiles"
