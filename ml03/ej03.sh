#!/bin/bash

. ./ej03_common.sh

./ej03_gen.sh

./ej03_train_ann.sh
./ej03_train_bayes.sh

PREDICTIONS=$(ls ${TEMP_DIR}/*.predic)

for file in ${PREDICTIONS}
do
    ./plotter.R ${file%.*} predic
done
