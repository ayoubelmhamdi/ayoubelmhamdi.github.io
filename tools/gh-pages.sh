#!/bin/bash

# dir="$PWD"
DIR="/root/book/ayoubelmhamdi.github.io"
ROOT="$(cd $DIR;git rev-parse --show-toplevel)"

if [[ -d "$ROOT" ]];then
    echo "project: $ROOT"
    echo
else
    echo "can't found your project in:"
    echo "$DIR"
    exit 1
fi

cd "$DIR"
if ! git worktree list | grep gh-pages >/dev/null 2>&1;then
    echo "no workspace gh-pages"
    rm book
    git branch gh-pages
    git worktree add book gh-pages
    cd book
    git rm -rf .
    git clean -fxd
    git update-ref -d refs/heads/gh-pages
fi

# fix
# git worktree remove /root/book/ayoubelmhamdi.github.io/book  && git branch -D gh-pages

# mdbook or exit
# result=$(/usr/bin/mdbook build "$dir" 2>&1 >/dev/null)
# status=$?

# echo "---"
# ls
cd "$DIR"
if ! mdbook build >/dev/null 2>&1;then
    echo "failed"
    mdbook build
    exit 1
fi

cd "$DIR/book"
fresh="nothing to commit, working tree clean"
getstatus="$(git status | grep "$fresh")"
if [[ "$getstatus" != "$fresh" ]];then
    git add .
    if ! git commit --amend --no-edit;then
        echo "first commit"
        git commit -m "expected: one commit"
    fi
    git push -u origin gh-pages --force
fi

