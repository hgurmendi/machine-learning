#!/bin/sh

# See `help set`
set -x
# set -v

# Load parameters for exercise 5
. ./ej05_common.sh

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm ${TEMP_DIR}/*

# Generate $GENERATIONS different training sets of sizes $TRAIN_SIZES for
# every generator in $GENERATORS
for g in ${GENERATORS}
do
    # Generate the test set that is shared between every training set of a
    # given generator
    echo "Generating test set of size ${TEST_SIZE} for the ${g} generator."

    GENERATOR_PATH=${GENERATORS_DIR}/${g}
    STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}
    
    ${GENERATOR_PATH} ${TEST_SIZE} ${PARAM_d} ${PARAM_C} ${STEM_PATH} 
    mv ${STEM_PATH}.data ${STEM_PATH}.test
    rm ${STEM_PATH}.names

    # Generate the training sets for every training size
    for n in ${TRAIN_SIZES}
    do
        for i in $(seq ${GENERATIONS})
        do
            STEM_CURRENT=${STEM_PATH}_${n}_${i}

            ${GENERATOR_PATH} ${n} ${PARAM_d} ${PARAM_C} ${STEM_CURRENT}

            # Symlink to the actual test set
            ln -s ${FILE_STEM}_${g}.test ${STEM_CURRENT}.test

            # ./plotter.R ${STEM_CURRENT} data
        done
    done
done
