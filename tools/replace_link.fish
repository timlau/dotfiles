#!/bin/fish
set link $argv[1]
set directory (dirname $link)
set target (readlink $link)
switch $target
    case '*/*'
        set source (realpath $directory/$target)
    case '*'
        set source $target
end
echo " ->> Replacing link: $link"
echo "          Directory: $directory"
echo "             Target: $target"
echo "               with: $source"
rm -fv $link
cp -afv $source $link
