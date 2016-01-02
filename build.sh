#!/bin/bash

git submodule update --init && ./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh && mvn clean install

cp Spigot-API/target/spigot-*-SNAPSHOT.jar .
cp Spigot-Server/target/spigot-*-SNAPSHOT.jar .
