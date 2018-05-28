#!/bin/bash

. ./ej_e_common.sh

./ej_e_gen.sh
./ej_e_calc.sh

./ej_e_plot.R ej07_parallel.errors ej07_diagonal.errors temp_e/e.mde
