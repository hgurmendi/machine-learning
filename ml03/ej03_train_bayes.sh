#!/bin/bash

. ./ej03_common.sh

# dos_elipses
echo "*** Training dataset dos_elipses with NB"

create_nbfile 2 2 ${TRAIN_SIZE_ELIPSES} ${TRAIN_SIZE_ELIPSES} ${TEST_SIZE_ELIPSES} 0 0 ${TEMP_DIR}/${FILE_STEM}_elipses_nb.nb

cp ${DATASET_STEM}.data ${TEMP_DIR}/${FILE_STEM}_elipses_nb.data
cp ${DATASET_STEM}.test ${TEMP_DIR}/${FILE_STEM}_elipses_nb.test

${NB_PATH} ${TEMP_DIR}/${FILE_STEM}_elipses_nb

echo "*** Finished training dataset dos_elipses with NB"

# spirals
echo "*** Training dataset spirals with NB"

create_nbfile 2 2 ${TRAIN_SIZE_SPIRALS} ${TRAIN_SIZE_SPIRALS} ${TEST_SIZE_SPIRALS} 0 0 ${TEMP_DIR}/${FILE_STEM}_spirals_nb.nb

cp ${TEMP_DIR}/${FILE_STEM}_spirals.data ${TEMP_DIR}/${FILE_STEM}_spirals_nb.data
cp ${TEMP_DIR}/${FILE_STEM}_spirals.test ${TEMP_DIR}/${FILE_STEM}_spirals_nb.test

${NB_PATH} ${TEMP_DIR}/${FILE_STEM}_spirals_nb

echo "*** Finished training dataset spirals with NB"
