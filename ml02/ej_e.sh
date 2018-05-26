#!/bin/bash

. ./ej_e_common.sh

./ej_e_gen.sh
./ej_e_calc.sh

./ej_e_plot.R temp_e/ej07_parallel.errors temp_e/ej07_diagonal.errors temp_e/e.mde
