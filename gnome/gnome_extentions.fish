#!/bin/fish
set installed_extentions $(gnome-extensions list --user)
set config_file ~/dotfiles/gnome/extensions.conf
set temp_dir $(mktemp -d .gnome_extensions_XXXXX)
cat "$config_file" -p | while read -l extension
    if not contains $extension $installed_extentions
        set version_tag $(curl -s "https://extensions.gnome.org/api/v1/extensions/$extension/versions/" | jq .count)
        set extension_url "https://extensions.gnome.org/api/v1/extensions/$extension/versions/$version_tag/?format=zip"
        echo " ->> Extension : $extension"
        # echo "            URL: $extension_url"
        if wget -q -O $temp_dir/$extension.zip $extension_url
            echo "     - Installing : $extension.zip"
            gnome-extensions install $temp_dir/$extension.zip
        else
            echo "     - Could not download : $extension.zip"
        end
    else
        echo " ->> $extension is allready installed"
    end
end
rm -rf $temp_dir
echo ""
echo "Logoff & Logon to make installed extensions active"
