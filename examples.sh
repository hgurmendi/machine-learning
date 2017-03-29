#! /bin/sh

if [ $# -ne 1 ]; then
    echo USAGE: $0 "<file>"
    exit
fi

echo Ejercicio a:
./ej_a 200 2 0.75 $1
./plotter.R $1
