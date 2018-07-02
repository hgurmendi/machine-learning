#!/bin/bash

. ./ej_b_common.sh

./ej_b_gen.sh
./ej_b_calc.sh

# Plot with ej_b_plotter.R the run that got the minimum test error.
# ./ej_b_plotter.R <stem> test
# ./ej_b_plotter.R <stem> predic
