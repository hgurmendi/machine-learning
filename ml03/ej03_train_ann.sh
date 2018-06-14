#!/bin/bash

. ./ej03_common.sh

# dos_elipses
echo "*** Training dataset dos_elipses with ANNs"

create_netfile 2 6 1 ${TRAIN_SIZE_ELIPSES} ${TRAIN_SIZE_ELIPSES} ${TEST_SIZE_ELIPSES} 40000 ${LR} ${MU} 400 0 0 0 ${TEMP_DIR}/${FILE_STEM}_elipses_ann.net

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
