#!/bin/bash

. ./ej03_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm -f ${TEMP_DIR}/*

# Generate spirals dataset for future use

# Train set
${GENERATOR} ${TRAIN_SIZE_SPIRALS} ${TEMP_DIR}/${FILE_STEM}_spirals_temp
rm ${TEMP_DIR}/${FILE_STEM}_spirals_temp.names
mv ${TEMP_DIR}/${FILE_STEM}_spirals_temp.data ${TEMP_DIR}/${FILE_STEM}_spirals.data

# Test set
${GENERATOR} ${TEST_SIZE_SPIRALS} ${TEMP_DIR}/${FILE_STEM}_spirals_temp
rm ${TEMP_DIR}/${FILE_STEM}_spirals_temp.names
mv ${TEMP_DIR}/${FILE_STEM}_spirals_temp.data ${TEMP_DIR}/${FILE_STEM}_spirals.test

