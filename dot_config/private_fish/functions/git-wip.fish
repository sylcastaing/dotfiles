#!/usr/bin/fish

function git-wip -d "Commit WIP (no-verify, skip CI)"
    git commit --no-verify -m "WIP [skip ci]"

    echo "WIP commit created successfully."
end
