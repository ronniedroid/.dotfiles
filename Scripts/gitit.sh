#!/bin/bash

# Check and see if PWD is a git repository, and whether you are in the root of it or not.
gittree=$(git rev-parse --is-inside-work-tree 2> /dev/null)

if [ "$gittree" == true ]; then
    if [ -d .git ]; then
        $Choice
    else
        printf "%s" "Not in the root of your git repository"
        exit 0
    fi
else
    printf "%s" "Not a git repository."
    exit 0
fi

# Print status in a clear way.
gstatus() {
    ST=$(git status | sed 's/modified://;s/new\ file://;s/deleted://;s/[[:space:]]//g;/^[[:space:]]*$/d;/On.*/d;/(use.*/d;s/Changestobecommitted/Staged\ Changes/;s/Changesnotstagedforcommit/Unstaged\ Changes/;s/Untrackedfiles/Untracked Files/;s/Yourbranchisuptodatewith/Up to do with remote repo\ /;s/Yourbranchisaheadof/Ahead of remote repo\ /;s/by/\ by\ /;s/commit/\ commit/')
    printf "%s\n" "$ST"
}

switchbranch() {
    l=$(git branch | fzf -i)
    s=$(git checkout $l)
}

listbranch() {
    l=$(git branch | fzf -i)
}

stage() {
    lu=$( gstatus | awk '/Unstaged.*/,/*/' | fzf -m --reverse)
    s=$(git add $lu)
}

unstage() {
    lS=$( gstatus | awk '/Staged.*/,/Unstaged.*/' | sed '/Unstaged.*/d'  | fzf -m --reverse)
    s=$(git restore --staged $lS)
}

commit() {
    read -p 'enter your commit message: ' message
    git commit -m "$message"
}

choice=$(echo -e "Status\nSwitch-branch\nlistbranchs\nstage\nunstage\ncommit\n" | fzf -i)

    case "$choice" in

        Status) gstatus ;;
        Switch-branch) switchbranch ;;
        listbranchs) listbranch ;;
        stage) stage && printf "%s\n%s" "staged changes" "$lu" ;;
        unstage) unstage && printf "%s\n%s" "Unstaged changes:" "$lS" ;;
        commit) commit
    esac

