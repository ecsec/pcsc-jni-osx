#!/bin/sh

echo Building library for OpenJDK 6
echo ==============================
echo
cd openjdk6
./build.sh

echo Building library for OpenJDK 7
echo ==============================
echo
cd ../openjdk7
./build.sh
