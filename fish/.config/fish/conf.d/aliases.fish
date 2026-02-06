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

function cm-clean-all --description "cmake all clean build directories"
    echo "Removing build directory..."
    rm -rf build
end

function cm-clean --description "cmake clean build directory (Release)"
    echo "Removing build directory..."
    rm -rf build/release
end
function cm-dbg-clean --description "cmake clean build directory (Debug)"
    echo "Removing build directory..."
    rm -rf build/debug
end

function cm-cfg --description "cmake -B -DCMAKE_BUILD_TYPE=Release"
    set cores (nproc)
    set cores (math $cores - 2)
    set -x CMAKE_BUILD_PARALLEL_LEVEL $cores
    cmake -B build/release -DCMAKE_BUILD_TYPE=Release -G Ninja $argv
end

function cm-dbg-cfg --description "cmake -B -DCMAKE_BUILD_TYPE=Debug"
    set cores (nproc)
    set cores (math $cores - 2)
    set -x CMAKE_BUILD_PARALLEL_LEVEL $cores
    cmake -B build/debug -DCMAKE_BUILD_TYPE=Debug -G Ninja $argv
end

function cm-build --description "cmake build"
    set cores (nproc)
    set cores (math $cores - 2)
    cmake --build build/release --config Release -j$cores $argv
end

function cm-dbg-build --description "cmake build"
    set cores (nproc)
    set cores (math $cores - 2)
    cmake --build build/debug --config Debug -j$cores $argv
end

function cm-cfg-rpm --description "cmake -B -DCMAKE_BUILD_TYPE=Release with RPM build flags"
    set cores (nproc)
    set cores (math $cores - 2)
    set -x CMAKE_BUILD_PARALLEL_LEVEL $cores
    set rpmflags $(rpm --eval '%{build_cxxflags}')
    set newflags (echo $rpmflags | string collect | string replace "flto=auto" "flto=$cores")
    echo "=> Using RPM CXXFLAGS: $newflags"
    CXXFLAGS=$newflags cmake -B build/release -DCMAKE_BUILD_TYPE=Release -G Ninja $argv
end

function cm-inst --description "cmake install in local .BUILDROOT/usr"
    rm -rf .BUILDROOT
    cmake --install build/release --prefix ./BUILDROOT/usr $argv
end

function cm-dbg-inst --description "cmake install in local .BUILDROOT/usr"
    rm -rf .BUILDROOT
    cmake --install build/debug --prefix ./BUILDROOT/usr $argv
end
