#!/bin/bash
basedir=`pwd`
git submodule update --init
./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh && mvn clean install
cp Spigot-API/target/spigot-*-SNAPSHOT.jar $basedir
cp Spigot-Server/target/spigot-*-SNAPSHOT.jar $basedir
cd $basedir

