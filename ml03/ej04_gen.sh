#!/bin/bash

. ./ej04_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm -f ${TEMP_DIR}/*

# Generate spirals dataset

# Train set
${GENERATOR} ${TOTAL_SIZE_SPIRALS} ${TEMP_DIR}/${FILE_STEM}_spirals_temp
rm ${TEMP_DIR}/${FILE_STEM}_spirals_temp.names
mv ${TEMP_DIR}/${FILE_STEM}_spirals_temp.data ${TEMP_DIR}/${FILE_STEM}_spirals.data

# Test set
${GENERATOR} ${TOTAL_SIZE_SPIRALS} ${TEMP_DIR}/${FILE_STEM}_spirals_temp
rm ${TEMP_DIR}/${FILE_STEM}_spirals_temp.names
mv ${TEMP_DIR}/${FILE_STEM}_spirals_temp.data ${TEMP_DIR}/${FILE_STEM}_spirals.test

cp ${DATASET_DIR}/${DATASET_STEM}.data ${TEMP_DIR}/${FILE_STEM}_elipses.data
cp ${DATASET_DIR}/${DATASET_STEM}.test ${TEMP_DIR}/${FILE_STEM}_elipses.test

for bins in ${BIN_SIZES_ELIPSES}
do
    FILESTEM=${TEMP_DIR}/${FILE_STEM}_elipses_${bins}

    ln -s ${FILE_STEM}_elipses.data ${FILESTEM}.data
    ln -s ${FILE_STEM}_elipses.test ${FILESTEM}.test
    
    create_nbfile 2 2 ${TOTAL_SIZE_ELIPSES} ${VALIDATION_SIZE_ELIPSES} ${TEST_SIZE_ELIPSES} 0 0 ${bins} ${FILESTEM}.nb

    echo "*** Training dos_elipses with bins=${bins}"
    ${NB_PATH} ${FILESTEM} > ${FILESTEM}.output

    echo "*** Finished training dos_elipses with bins=${bins}"
done

for bins in ${BIN_SIZES_ELIPSES}
do
    FILESTEM=${TEMP_DIR}/${FILE_STEM}_spirals_${bins}

    ln -s ${FILE_STEM}_spirals.data ${FILESTEM}.data
    ln -s ${FILE_STEM}_spirals.test ${FILESTEM}.test
    
    create_nbfile 2 2 ${TOTAL_SIZE_SPIRALS} ${VALIDATION_SIZE_SPIRALS} ${TEST_SIZE_SPIRALS} 0 0 ${bins} ${FILESTEM}.nb

    echo "*** Training spirals with bins=${bins}"
    ${NB_PATH} ${FILESTEM} > ${FILESTEM}.output

    echo "*** Finished training spirals with bins=${bins}"
done
