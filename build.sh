#!/bin/bash
git submodule update --init
cd Spigot
./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh && mvn clean install
cd ..
cp Spigot-API/target/spigot-*-SNAPSHOT.jar .
cp Spigot-Server/target/spigot-*-SNAPSHOT.jar .
