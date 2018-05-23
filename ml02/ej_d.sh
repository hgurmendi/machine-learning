#!/bin/bash

. ./ej_d_common.sh

./ej_d_gen.sh
./ej_d_calc.sh

for GAMMA in ${GAMMAS}
do
    echo "Plotear: ${TEMP_DIR}/${TEMP_STEM}_${GAMMA}.mse.avg"
done
