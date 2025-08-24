#!/usr/bin/env fish

function git-wip -d "Commit WIP (no-verify, skip CI)"
    git commit -a -m "WIP [skip ci]" --no-verify

    echo "WIP commit created successfully."
end
