#!/bin/bash

. ./ej04_common.sh

echo "bins, Training, Validation, Test" > ${TEMP_DIR}/${FILE_STEM}_elipses.errors
echo "bins, Training, Validation, Test" > ${TEMP_DIR}/${FILE_STEM}_spirals.errors

for bins in ${BIN_SIZES_ELIPSES}
do
    FILESTEM=${TEMP_DIR}/${FILE_STEM}_elipses_${bins}

    ERR_TRAIN=$(grep "Entrenamiento" ${FILESTEM}.output | awk -F ':' '{gsub(/(%| )/,""); print $2}')
    ERR_VALID=$(grep "Validacion" ${FILESTEM}.output | awk -F ':' '{gsub(/(%| )/,""); print $2}')
    ERR_TEST=$(grep "Test" ${FILESTEM}.output | awk -F ':' '{gsub(/(%| )/,""); print $2}')

    echo "${bins}, ${ERR_TRAIN}, ${ERR_VALID}, ${ERR_TEST}" >> ${TEMP_DIR}/${FILE_STEM}_elipses.errors
done

for bins in ${BIN_SIZES_SPIRALS}
do
    FILESTEM=${TEMP_DIR}/${FILE_STEM}_spirals_${bins}

    ERR_TRAIN=$(grep "Entrenamiento" ${FILESTEM}.output | awk -F ':' '{gsub(/(%| )/,""); print $2}')
    ERR_VALID=$(grep "Validacion" ${FILESTEM}.output | awk -F ':' '{gsub(/(%| )/,""); print $2}')
    ERR_TEST=$(grep "Test" ${FILESTEM}.output | awk -F ':' '{gsub(/(%| )/,""); print $2}')

    echo "${bins}, ${ERR_TRAIN}, ${ERR_VALID}, ${ERR_TEST}" >> ${TEMP_DIR}/${FILE_STEM}_spirals.errors
done


