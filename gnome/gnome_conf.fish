#!/bin/fish
argparse h/help -- $argv
or return

# Constants
set usage "Usage: gnome_conf [-h | --help] backup|restore"
set main_dir ~/dotfiles/gnome
set config_file $main_dir/sections.conf
set backup_dir $main_dir/settings

# Checking for _flag_h and _flag_help is equivalent
# We check if it has been given at least once
if set -ql _flag_h
    echo "$usage" >&2
    return 1
end

# cheak that there is some arguments
if test (count $argv) -eq 0
    echo "$usage" >&2
    return 1
end

# chwck that there is legal argument
set legal_commands backup restore
set command (string lower $argv[-1])
if not contains $command $legal_commands
    echo "$usage" >&2
    return 1
end

# Function: process_paths
# Description: Reads a config file and outputs "section_path [TAB] filename.ini"
function process_paths
    set -l config_file ~/dotfiles/gnome/sections.conf
    cat "$config_file" | while read -l line
        # Clean the line and skip comments/empty space
        set -l clean_line (string trim $line)
        if test -z "$clean_line"; or string match -q "#*" "$clean_line"
            continue
        end

        # Generate the filename
        set -l filename (string trim --chars=/ $clean_line | string replace --all '/' '_').ini

        # Return both values separated by a tab
        echo -e "$clean_line\t$filename"
    end
end

# Capture the function output and iterate through the pairs
process_paths | while read -l -d \t section backup_file
    switch $command
        case backup
            echo " ->> backup $section into $backup_dir/$backup_file"
            dconf dump $section >$backup_dir/$backup_file
        case restore
            echo " ->> restore $section from $backup_dir/$backup_file"
            dconf load $section <$backup_dir/$backup_file
    end
end
