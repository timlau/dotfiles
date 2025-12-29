#!/bin/fish
set config_file ~/dotfiles/gnome/extensions.conf
set temp_dir $(mktemp -d .gnome_extensions_XXXXX)
cat "$config_file" -p | while read -l extension
    set version_tag $(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$extension" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    set extension_url "https://extensions.gnome.org/download-extension/$extension?version_tag=$version_tag"
    echo " ->> Extension : $extension"
    echo "            URL: $extension_url"
    if wget -q -O $temp_dir/$extension.zip $extension_url
        echo "     - Downloaded : $extension.zip"
    else
        echo "     - Could not download : $extension.zip"
    end
end
tree -f $temp_dir
rm -rf $temp_dir
