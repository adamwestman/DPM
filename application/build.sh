echo "Starting DPM compiling from $(pwd)"

mkdir build
pushd vendor/srlua
    echo "Make SRLua from $(pwd)"
    make
popd


echo "Compile DPM from source at ${pwd}/src/"
vendor/srlua/glue vendor/srlua/srlua src/main.lua build/dpm.o
chmod +x build/dpm.o

echo "Execute DPM at ${pwd}/build/dpm.o"
./build/dpm.o -v --help