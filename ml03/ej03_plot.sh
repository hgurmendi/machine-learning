#!/bin/bash

. ./ej03_common.sh

PREDICTIONS=$(ls ${TEMP_DIR}/*.predic)

for file in ${PREDICTIONS}
do
    ${PLOTTER_PATH} ${file%.*} predic
done

cp ${DATASET_STEM}.test ${TEMP_DIR}/${FILE_STEM}_elipses.test

${PLOTTER_PATH} ${TEMP_DIR}/${FILE_STEM}_elipses test
${PLOTTER_PATH} ${TEMP_DIR}/${FILE_STEM}_spirals test
