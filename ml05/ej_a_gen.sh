#!/bin/bash

. ./ej_a_common.sh

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

    for method in ${METHODS}
    do
        for suffix in data test
        do
            cp ${STEM}.${suffix} ${STEM}_${method}.${suffix}
        done
    done

    # And the .names file
    cp ${DATASET_PATH}.names ${STEM}_dt.names

    create_nbfile 6 2 450 450 50 $(gen_rand) 0 ${STEM}_nbc.nb
done


