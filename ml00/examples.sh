#! /bin/sh

if [ $# -ne 1 ]; then
    echo USAGE: $0 "<output>"
    exit
fi

echo "Ejercicio a (1):"
./ej_a 200 2 0.75 $1_a_1
./plotter.R $1_a_1

echo "Ejercicio a (2):"
./ej_a 2000 4 2.00 $1_a_2

echo "Ejercicio b (1):"
./ej_b 200 2 0.75 $1_b_1
./plotter.R $1_b_1

echo "Ejercicio b (2):"
./ej_b 2000 4 2.00 $1_b_2

echo "Ejercicio c (1):"
./ej_c 2000 $1_c_1
./plotter.R $1_c_1

echo "Ejercicio c (2):"
./ej_c 6000 $1_c_2
./plotter.R $1_c_2
