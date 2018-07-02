#!/bin/bash

. ./ej_b_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm ${TEMP_DIR}/*

for i in $(seq ${GENERATIONS})
do
    GENERATOR_PATH=${GENERATORS_DIR}/${GENERATOR}
    STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${i}

    ${GENERATOR_PATH} ${TEST_SIZE} ${STEM_PATH}
    mv ${STEM_PATH}.data ${STEM_PATH}.test
    rm ${STEM_PATH}.names

    ${GENERATOR_PATH} ${TRAIN_SIZE} ${STEM_PATH}
    rm ${STEM_PATH}.names

    create_knnfile 2 2 ${TRAIN_SIZE} ${TRAIN_SIZE} ${TEST_SIZE} 0 0 ${K} ${STEM_PATH}.knn 
done

