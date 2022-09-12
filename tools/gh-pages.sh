#!/bin/bash

ROOT="$(git rev-parse --show-toplevel)"

if [[ -d "$ROOT" ]];then
    echo "project: $ROOT"
    echo
else
    echo "can't found your project in:"
    echo "$PWD"
    exit 1
fi

cd "$ROOT"
echo "$ROOT"

if ! git worktree list | grep gh-pages >/dev/null 2>&1;then

    # if not have woktree, perhaps , we don't have branch gh-pages
    echo "no worktree called gh-pages"
    # git branch gh-pages || true

    git worktree add gh-pages || echo "can't create worktree"
    echo 'echo 1'

    # perhaps i don't needed when i use --dist-dir=/tmp/..
    if ! cd gh-pages ;then
        echo "non dir gh-pahes"
        exit 1
    else
        echo 'cd work'
        pwd
    fi
    echo 'echo 2'
    git rm -rf . 
    git clean -fxd
    git update-ref -d refs/heads/gh-pages
fi



cd "$ROOT"
if ! mdbook build >/dev/null 2>&1;then
    echo "failed"
    mdbook build
    exit 1
fi

# t for preserve old time
rsync -t --checksum book/html/* gh-pages --out-format="--> %f"

if ! cd gh-pages ;then
    echo "non dir gh-pahes"
    exit 1
fi


fresh="nothing to commit, working tree clean"
getstatus="$(git status | grep "$fresh")"
if [[ "$getstatus" != "$fresh" ]];then
    git add .
    git commit -m "commit $(date)"
    git push --set-upstream origin gh-pages -f
else
    echo "status no"
fi
