#!/bin/sh

# See `help set`
set -x
# set -v

# Load parameters for exercise 6
. ./ej06_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm ${TEMP_DIR}/*

for g in ${GENERATORS}
do
    for c in ${PARAM_C}
    do
        echo "Generating test set for the ${g} generator of size ${TEST_SIZE} with C=${c}."

        GENERATOR_PATH=${GENERATORS_DIR}/${g}
        STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${c}

        ${GENERATOR_PATH} ${TEST_SIZE} ${PARAM_d} ${c} ${STEM_PATH}
        mv ${STEM_PATH}.data ${STEM_PATH}.test
        rm ${STEM_PATH}.names

        echo "Finished test set generation for the ${g} generator with C=${c}."

        for i in $(seq ${GENERATIONS})
        do
            STEM_CURRENT=${STEM_PATH}_${i}
            
            ${GENERATOR_PATH} ${TRAIN_SIZE} ${PARAM_d} ${c} ${STEM_CURRENT}

            # Create link to test file
            ln -s ${FILE_STEM}_${g}_${c}.test ${STEM_CURRENT}.test
        done
    done
done

