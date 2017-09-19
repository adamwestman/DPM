# DPM

Here lies the Application source used to build DPM.

Source is based on Lua 5.1

## Compilation

### Required
* lua
* npm

Uses [lua-destiller](https://github.com/yi/node-lua-distiller) and [SRLua](https://github.com/LuaDist/srlua) to compile an executable from multiple lua source files.

 To compile an executable from source simply call the build.sh script:
```sh
$ ./build.sh
```
build.sh will:
1. Verify dependencies and download if possible.
1. Compile all lua source files in ```src/```
1. Output combined lua in ```build/dist.lua```
1. Invoke the Makefile inside ```vendor/srlua```
1. Compile executable from ```src/main.lua```
1. Output compiled executable output in ```build/dpm.o```
1. Execute ```$ ./build/dpm.o -V --help```

