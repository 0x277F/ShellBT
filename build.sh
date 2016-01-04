#!/bin/bash
basedir=`pwd`
git submodule update --init
./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh && mvn -f Spigot/pom.xml clean install
cp Spigot/Spigot-API/target/spigot-*-SNAPSHOT.jar $basedir
cp Spigot/Spigot-Server/target/spigot-*-SNAPSHOT.jar $basedir
cd $basedir

