#!/bin/sh

FILE_STEM=ej05
C45_PATH=./c4.5r8/Src/c4.5
TEST_SIZE=10000
TRAIN_SIZES="125 250 500 1000 2000 4000"
GENERATORS_DIR=../ml00
GENERATORS="diagonal parallel"
GENERATIONS=20
TEMP_DIR=temp05

PARAM_C=0.78
PARAM_d=2

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
        for i in $(seq 20)
        do
            STEM_CURRENT=${STEM_PATH}_${n}_${i}

            ${GENERATOR_PATH} ${n} ${PARAM_d} ${PARAM_C} ${STEM_CURRENT}

            # Symlink to the actual test set
            ln -s ${FILE_STEM}_${g}.test ${STEM_CURRENT}.test
        done
    done
done
