#!/usr/bin/env fish

function generate-completions --description "Generate fish completions for specified commands"
    switch $argv[1]
        case docker
            docker completion fish >~/.config/fish/completions/docker.fish
            echo "Docker completions generated and saved to ~/.config/fish/completions/docker.fish"
        case volta
            volta completions fish >~/.config/fish/completions/volta.fish
            echo "Volta completions generated and saved to ~/.config/fish/completions/volta.fish"
        case '*'
            echo "Unknown command: $argv[1]"
            echo "Usage: fish <docker|volta>"
    end
end
