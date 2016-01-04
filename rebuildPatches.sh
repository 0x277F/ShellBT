#!/bin/bash

PS1="$"
basedir=`pwd`/Spigot
cd $basedir
echo "Rebuilding patch files from current fork state..."
git config core.safecrlf false

function cleanupPatches {
    cd "$1"
    for patch in *.patch; do
        echo "$patch"
        gitver=$(tail -n 2 $patch | grep -ve "^$" | tail -n 1)
        diffs=$(git diff --staged $patch | grep -E "^(\+|\-)" | grep -Ev "(From [a-z0-9]{32,}|\-\-\- a|\+\+\+ b|.index)")

        testver=$(echo "$diffs" | tail -n 2 | grep -ve "^$" | tail -n 1 | grep "$gitver")
        if [ "x$testver" != "x" ]; then
            diffs=$(echo "$diffs" | sed 'N;$!P;$!D;$d')
        fi

        if [ "x$diffs" == "x" ] ; then
            git reset HEAD $patch >/dev/null
            git checkout -- $patch >/dev/null
        fi
    done
}

function savePatches {
    what=$1
    target=$2
    echo "Formatting patches for $what..."
    cd "$basedir/$target"
    git format-patch --no-stat -N -o "$basedir/${what}-Patches/" upstream/upstream >/dev/null
    cd "$basedir"
    git add -A "$basedir/${what}-Patches"
    cleanupPatches "$basedir/${what}-Patches"
    echo "  Patches saved for $what to $what-Patches/"
}
if [ "$1" == "clean" ]; then
	rm -rf Spigot-*-Patches
fi
savePatches Bukkit Spigot-API
savePatches CraftBukkit Spigot-Server
cd ..
