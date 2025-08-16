#!/usr/bin/env fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source

fisher install jorgebucaran/fisher
fisher install catppuccin/fish

fish_config theme save "Catppuccin Mocha"
