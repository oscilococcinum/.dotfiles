if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting
alias nswitch="sudo nixos-rebuild switch --flake ~/.dotfiles/ --impure"
alias nsh="nix-shell --run fish"
alias cdh="cd ~/"
alias v="nvim ."
alias ll="ls -l"
alias l="ls -la"
alias .="ls -l"
alias q="exit"
alias v="nvim ."
alias vi="nvim"
