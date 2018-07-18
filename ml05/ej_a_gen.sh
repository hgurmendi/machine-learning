#!/bin/bash

. ./ej_a_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm -f ${TEMP_DIR}/*

echo "C, Train, Validation" > ${TEMP_DIR}/${FILE_STEM}_svm.errors

for c in ${PARAM_C}
do
    echo "Running SVM with C=${c}"

    ${SVM_PATH} -i ${DATASET} -f ${FOLDS} -C ${c} > ${TEMP_DIR}/${FILE_STEM}_svm_${c}.output

    ERR_VALID=$(grep "validacion" ${TEMP_DIR}/${FILE_STEM}_svm_${c}.output | awk -F ':' '{print $2}')
    ERR_TRAIN=$(grep "train" ${TEMP_DIR}/${FILE_STEM}_svm_${c}.output | awk -F ':' '{print $2}')

    echo "${c}, ${ERR_TRAIN}, ${ERR_VALID}" >> ${TEMP_DIR}/${FILE_STEM}_svm.errors
done
