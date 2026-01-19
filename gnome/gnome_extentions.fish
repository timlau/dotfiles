#!/bin/fish
argparse h/help v/verbose -- $argv
or return
set usage "Usage: gnome_extension.fish [-h | --help][-v | --verbose]"
# Checking for _flag_h and _flag_help is equivalent
# We check if it has been given at least once
if set -ql _flag_h
    echo "$usage" >&2
    return 1
end
if set -ql _flag_v
    set verbose 1
else
    set verbose 0
end

set installed_extentions $(gnome-extensions list --user)
set config_file ~/dotfiles/gnome/extensions.conf
set temp_dir $(mktemp -d .gnome_extensions_XXXXX)
cat "$config_file" | while read -l extension
    if not contains $extension $installed_extentions
        echo " ->> Extension : $extension"
        set version_tag $(curl -s "https://extensions.gnome.org/api/v1/extensions/$extension/versions/?page=1&page_size=100" | jq .count)
        set extension_url "https://extensions.gnome.org/api/v1/extensions/$extension/versions/$version_tag/?format=zip"
        if test $verbose -eq 1
            echo "       version : $version_tag"
            echo "           URL : $extension_url"
        end
        if wget -q -O $temp_dir/$extension.zip $extension_url
            echo "    Installing : $extension.zip"
            gnome-extensions install $temp_dir/$extension.zip
        else
            echo "    download failed : $extension.zip"
        end
    else
        echo " ->> $extension is allready installed"
    end
end
rm -rf $temp_dir
echo ""
echo "Logoff & Logon to make installed extensions active"
