#!/bin/bash

. ./ej_a_common.sh

./ej_a_gen.sh
./ej_a_calc.sh

for LR in ${LEARNING_RATES}
do
    for MU in ${MOMENTUMS}
    do
        ./ej_a_plot.R ${TEMP_DIR}/${TEMP_STEM}_${LR}_${MU}.mse.avg ${TEMP_STEM}_${LR}_${MU}.png
    done
done
