#!/bin/bash

. ./ej04_common.sh

./ej04_gen.sh
./ej04_calc.sh

./ej04_plot.R ${TEMP_DIR}/${FILE_STEM}_elipses.errors ${TEMP_DIR}/${FILE_STEM}_spirals.errors

