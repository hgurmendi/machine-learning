#!/bin/bash

. ./ej_c_common.sh

./ej_c_gen.sh
./ej_c_calc.sh

for PT in ${PERCENTAGES_TRAINING}
do
    ./ej_c_plot.R ${TEMP_DIR}/${TEMP_STEM}_${PT}.mse.avg
done
