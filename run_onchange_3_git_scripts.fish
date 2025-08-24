#!/usr/bin/env fish

set -l commands git-clean-merged git-wip git-unwip

set -l source_dir "$HOME/.config/fish/functions"
set -l dest_dir "$HOME/.local/bin"

# Create $dest_dir if not exists 
if not test -d "$dest_dir"
    mkdir -p "$dest_dir"
    echo "$dest_dir created"
end

for cmd in $commands
    set -l source "$source_dir/$cmd.fish"
    set -l dest "$dest_dir/$cmd"

    # Create wrapper
    echo "#!/bin/sh" >"$dest"
    echo "fish -c \"$cmd\" \"\$@\"" >>"$dest"

    chmod +x "$dest"
end
