#!/bin/bash

. ./ej04_common.sh

# dos_elipses

# Get validation set size (10% of total size)
VALIDATION_SIZE_ELIPSES=$(expr "${TOTAL_SIZE_ELIPSES} / 10")
BIN_SIZES_ELIPSES="10 $(expr $(expr "${TOTAL_SIZE_ELIPSES} / 20") $(expr "${TOTAL_SIZE_ELIPSES} / 20") $(expr "${TOTAL_SIZE_ELIPSES} / 2"))"

echo "*** Training dos_elipses with validation=${VALIDATION_SIZE_ELIPSES}, bins=${BIN_SIZES_ELIPSES}"

for bins in ${BIN_SIZES_ELIPSES}
do
    STEM=${TEMP_DIR}/${FILE_STEM}_elipses_${bins}

    cp ${TEMP_DIR}/${FILE_STEM}_elipses.data ${STEM}.data
    cp ${TEMP_DIR}/${FILE_STEM}_elipses.test ${STEM}.test
    create_nbfile 2 2 ${TOTAL_SIZE_ELIPSES} ${VALIDATION_SIZE_ELIPSES} ${TEST_SIZE_ELIPSES} 0 0 ${bins} ${STEM}.nb


done


cp ${DATASET_STEM}.data ${TEMP_DIR}/${FILE_STEM}_elipses_ann.data
cp ${DATASET_STEM}.test ${TEMP_DIR}/${FILE_STEM}_elipses_ann.test

${BP_PATH} ${TEMP_DIR}/${FILE_STEM}_elipses_ann

echo "*** Finished training dataset dos_elipses with ANNs"

# spirals
echo "*** Training dataset spirals with ANNs"

create_netfile 2 20 1 ${TRAIN_SIZE_SPIRALS} ${TRAIN_SIZE_SPIRALS} ${TEST_SIZE_SPIRALS} 40000 ${LR} ${MU} 400 0 0 0 ${TEMP_DIR}/${FILE_STEM}_spirals_ann.net

cp ${TEMP_DIR}/${FILE_STEM}_spirals.data ${TEMP_DIR}/${FILE_STEM}_spirals_ann.data
cp ${TEMP_DIR}/${FILE_STEM}_spirals.test ${TEMP_DIR}/${FILE_STEM}_spirals_ann.test

${BP_PATH} ${TEMP_DIR}/${FILE_STEM}_spirals_ann

echo "*** Finished training dataset spirals with ANNs"
