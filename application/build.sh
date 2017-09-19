#!/bin/bash

echo "Starting DPM compiling from $(pwd)"

## Setup Dependencies
echo
echo "Validate compile dependencies"
source ./vendor/is_installed.sh

if [ $(program_is_installed luac) == 0 ]; then
    echo_fail "luac is required";
    exit
else
    echo_pass "luac"
fi

if [ $(program_is_installed npm) == 0 ]; then
    echo_fail "npm is required";
    exit
else
    echo_pass "npm"
fi

if [ $(program_is_installed lua-distill) == 0 ]; then
    echo_fail "lua-distill is required";
    echo "installing"
    npm install coffee-script lua-distiller -g --ignore-scripts
else
    echo_pass "lua-distill"
fi

## Prepare build
echo
echo "Setup build folder"
mkdir build

echo
echo "Compile Lua from source at ${pwd}/src/"
lua-distill -i src/main.lua -o build/dist.lua

## Setup SRLua
pushd vendor/srlua
    echo
    echo "Make SRLua from $(pwd)"
    make
popd

echo
echo "Compile DPM executable from compiled lua at build/dist.lua using SRLua"
vendor/srlua/glue vendor/srlua/srlua build/dist.lua build/dpm.o
chmod +x build/dpm.o

echo
echo "Execute DPM at ${pwd}/build/dpm.o"
./build/dpm.o -V --help


: <<'=cut'
=cut