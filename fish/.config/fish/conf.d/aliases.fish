# This file is managed by Ansible. Do not edit manually.

# Define aliases (which are functions in fish)
function ll --wraps ls --description 'alias ll=ls -lhA'
    ls -lhA $argv
end

function gco --wraps git --description 'alias gco=git checkout'
    git checkout $argv
end

function cat --wraps bat --description 'alias cat=bat'
    bat $argv
end

function lg --wraps lazygit --description 'alias lg=lazygit'
    lazygit $argv
end

function vi --wraps nvim --description 'alias vi=nvim'
    nvim $argv
end

function upd --description 'update dotfiles to/from github'
    set current_dir $(pwd)
    cd ~/dotfiles
    git add .
    git commit -a -m ". update configuration"
    git pull --rebase origin main
    git push
    cd $current_dir
end

function y --description 'yazi filemanager change to cwd on exit'
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
