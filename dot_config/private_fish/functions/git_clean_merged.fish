function git_clean_merged --description "Delete all local Git branches already merged into the specified branch (default: main)"
    set -l base_branch main
    if test (count $argv) -gt 0
        set base_branch $argv[1]
    end

    set -l merged_branches (git branch --merged=$base_branch | grep -v $base_branch | sed 's/^[ *]*//')

    if test (count $merged_branches) -eq 0
        echo "No branches merged into $base_branch to delete."
        return 0
    end

    echo "Deleting branches merged into $base_branch:"
    echo $merged_branches

    for branch in $merged_branches
        git branch -d $branch
    end

    git fetch --prune
end
