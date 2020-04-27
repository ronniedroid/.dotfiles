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
    ST=$(git status | sed 's/modified://;s/new\ file://;s/deleted://;s/[[:space:]]//g;/^[[:space:]]*$/d;/On.*/d;/(use.*/d;s/Changestobecommitted/Staged\ Changes:/;s/Changesnotstagedforcommit/Unstaged\ Changes:/;s/Untrackedfiles/Untracked Files/;s/Yourbranchisuptodatewith/Up to do with remote repo\ /;s/Yourbranchisaheadof/Ahead of remote repo\ /;s/by/\ by\ /;s/commit/\ commit/')
    printf "%s\n" "$ST"
}

switchbranch() {
    l=$(git branch | fzf -i)
    s=$(git checkout $l)
}

listbranch() {
    l=$(git branch)
    printf "%s" "$l"
}

stage() {
    lu=$( gstatus | awk '/Unstaged.*/,/*/' | fzf -m --reverse)
    if [ -z $lu ]; then
        printf "%s" "Nothing selected to stage"
        exit 0
    else
        s=$(git add $lu 2> /dev/null)
    fi
}

unstage() {
    lS=$( gstatus | awk '/Staged.*/,/Unstaged.*/' | sed '/Unstaged.*/d'  | fzf -m --reverse)
    if [ -z $lS ];then
        printf "%s" "Nothing selected to unstage"
        exit 0
    else
        s=$(git restore --staged $lS  2> /dev/null)
    fi
}

commit() {
    read -p 'enter your commit message: ' message
    git commit -m "$message"
}

listremote() {
    LR=$(git remote -v)
    printf "%s" "$LR"
}

pull() {
    remote=$(listremote | grep "fetch" | awk '{print $1}' | fzf -m)
    branch=$(listbranch | fzf -m)
    git pull $remote $branch
}

push() {
    remote=$(listremote | grep "push" | awk '{print $1}' | fzf -m)
    branch=$(listbranch | fzf -m)
    git push $remote $branch
}

choice=$(echo -e "Status\nSwitch-branch\nlist-branchs\nstage\nunstage\ncommit\nlist-remotes\npull\npush" | fzf -i)

    case "$choice" in

        Status) gstatus ;;
        Switch-branch) switchbranch ;;
        list-branchs) listbranch ;;
        stage) stage && printf "%s\n%s" "staged changes" "$lu" ;;
        unstage) unstage && printf "%s\n%s" "Unstaged changes:" "$lS" ;;
        list-remotes) listremote ;;
        commit) commit ;;
        pull) pull ;;
        push) push
    esac

