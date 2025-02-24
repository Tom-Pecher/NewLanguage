
if [ ! -f src/compiler ]; then
    cd src
    ./compile_compiler.sh
    cd ..
fi

cat script | src/compiler
