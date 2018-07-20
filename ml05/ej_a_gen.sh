#!/bin/bash

. ./ej_a_common.sh

set -x

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm -f ${TEMP_DIR}/*

cp ${DATASET_PATH}.data ${TEMP_DIR}/${FILE_STEM}.data
cp ${DATASET_PATH}.names ${TEMP_DIR}/${FILE_STEM}.names

# Generate the folds
${KFOLDS_PATH} -f ${FOLDS} -i ${TEMP_DIR}/${FILE_STEM} >/dev/null

# Generate the .data and .test files for each method
for i in $(seq 0 1 $(expr ${FOLDS} - 1))
do
    STEM=${TEMP_DIR}/${FILE_STEM}_${i}

    for method in svml svmr dt nbc
    do
        for suffix in data test
        do
            cp ${STEM}.${suffix} ${STEM}_${method}.${suffix}
        done
    done

    # And the .names file
    cp ${DATASET_PATH}.names ${STEM}_dt.names
done


