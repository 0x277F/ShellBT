#!/bin/bash
basedir=`pwd`
cd Spigot
if [ ! -d "$basedir/Spigot/.git" ]; then
    git init
    git remote add -f origin https://hub.spigotmc.org/stash/scm/spigot/spigot.git
fi
git fetch
git checkout -t origin/master
cd $basedir

git submodule update --init
./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh && mvn -f Spigot/pom.xml clean install
cp Spigot/Spigot-API/target/spigot-*-SNAPSHOT.jar $basedir
cp Spigot/Spigot-Server/target/spigot-*-SNAPSHOT.jar $basedir
cd $basedir

