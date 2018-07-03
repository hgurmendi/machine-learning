#!/bin/bash

. ./ej_c_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm ${TEMP_DIR}/*

for g in ${GENERATORS}
do
    for d in ${PARAM_d}
    do
        GENERATOR_PATH=${GENERATORS_DIR}/${g}
        STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${d}

        ${GENERATOR_PATH} ${TEST_SIZE} ${d} ${PARAM_C} ${STEM_PATH}
        mv ${STEM_PATH}.data ${STEM_PATH}.test
        rm ${STEM_PATH}.names

        for i in $(seq ${GENERATIONS})
        do
            STEM_CURRENT=${STEM_PATH}_${i}
            
            ${GENERATOR_PATH} ${TRAIN_SIZE} ${d} ${PARAM_C} ${STEM_CURRENT}
            rm ${STEM_CURRENT}.names

            # Create link to test file
            ln -s ${FILE_STEM}_${g}_${d}.test ${STEM_CURRENT}.test

            # Create knnfile
            create_knnfile ${d} 2 ${TOTAL_SIZE} ${TRAIN_SIZE} ${TEST_SIZE} $(gen_rand) 0 ${K} ${STEM_CURRENT}.knn
        done
    done
done

