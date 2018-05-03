#!/bin/sh

# See `help set`
set -x
# set -v

# Load parameters for exercise 6
. ./ej07_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm ${TEMP_DIR}/*

for g in ${GENERATORS}
do
    for d in ${PARAM_d}
    do
        echo "Generating test set for the ${g} generator of size ${TEST_SIZE} with d=${d}."

        GENERATOR_PATH=${GENERATORS_DIR}/${g}
        STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${d}

        ${GENERATOR_PATH} ${TEST_SIZE} ${d} ${PARAM_C} ${STEM_PATH}
        mv ${STEM_PATH}.data ${STEM_PATH}.test
        rm ${STEM_PATH}.names

        echo "Finished test set generation for the ${g} generator with d=${d}."

        for i in $(seq ${GENERATIONS})
        do
            STEM_CURRENT=${STEM_PATH}_${i}
            
            ${GENERATOR_PATH} ${TRAIN_SIZE} ${d} ${PARAM_C} ${STEM_CURRENT}

            # Create link to test file
            ln -s ${FILE_STEM}_${g}_${d}.test ${STEM_CURRENT}.test
        done
    done
done

