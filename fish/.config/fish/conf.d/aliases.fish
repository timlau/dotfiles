# Define aliases (which are functions in fish)
function ll --wraps ls --description 'alias ll=ls -lhA'
    ls -lhA $argv
end

function gco --wraps git --description 'alias gco=git checkout'
    git checkout $argv
end

function lg --wraps lazygit --description 'alias lg=lazygit'
    lazygit $argv
end

function vi --wraps nvim --description 'alias vi=nvim'
    nvim $argv
end

function upd-back --description 'update dotfiles to/from github and backup gnome settings'
    set current_dir $(pwd)
    cd $HOME/dotfiles
    # check for optional commit message
    if test (count $argv) -eq 0
        make sync-backup
    else
        COMMIT_MSG=$argv make sync-backup
    end
    cd $current_dir
end

function upd --description 'update dotfiles to/from github and restore gnome settings'
    set current_dir $(pwd)
    cd $HOME/dotfiles
    # check for optional commit message
    if test (count $argv) -eq 0
        make sync-restore
    else
        COMMIT_MSG=$argv make sync-restore
    end
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

function repo-upd --description "update local audio reop"
    createrepo_c $HOME/OneDrive/RPMS
end

function cm-cfg --description "cmake -B -DCMAKE_BUILD_TYPE=Release"
    cmake -B build -DCMAKE_BUILD_TYPE=Release -G Ninja $argv
end

function cm-build --description "cmake build"
    set cores (nproc)
    set cores (math $cores - 1)
    cmake --build build --config Release -j$cores $argv
end
