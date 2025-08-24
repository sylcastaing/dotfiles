#!/usr/bin/env fish

function git-unwip -d "Reset the last WIP commit and restore changes to the staged area"
    set last_commit_msg (git log -1 --pretty=%B)

    if string match -q "WIP*" "$last_commit_msg"
        git reset --soft HEAD~1
        echo "The last WIP commit has been removed. Changes are back in the staged area."
    else
        echo "The last commit is not a WIP. No action taken."
    end
end
