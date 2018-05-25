#!/bin/bash

. ./ej_e_common.sh

run_training () {
    # Generator
    local GEN=$1
    # Number of dimensions
    local DIM=$2
    # Index of the current run
    local INDEX=$3
    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}_${GEN}_${DIM}_${INDEX}
    # Random seed
    local SEED=$(gen_rand)
    # Generator path
    local GEN_PATH=${GENERATORS_DIR}/${GEN}

    echo "**** Running training with gen=${GEN}, dim=${DIM}, seed=${SEED}, round=${INDEX}"
    create_netfile ${DIM} 6 1 ${TOTAL_DATA} ${TOTAL_TRAIN} ${TOTAL_TEST} ${EPOCHS} 0.01 0.5 ${RECORD_RATE} 0 ${SEED} 0 ${FILESTEM}.net

    # Generate train dataset and symlink test dataset
    ${GEN_PATH} ${TOTAL_TRAIN} ${DIM} ${GENERATORS_C} ${FILESTEM} > /dev/null
    rm ${FILESTEM}.names

    ln -s ${TEMP_STEM}_${GEN}_${DIM}.test ${FILESTEM}.test

    ${BP} ${FILESTEM} > ${FILESTEM}.output

    echo "**** Finished running training with gen=${GEN}, dim=${DIM}, seed=${SEED}, round=${INDEX}"
}
export -f run_training

# Create temporary directory if it doesn't exist
if [ ! -d ${TEMP_DIR} ];
then
    mkdir ${TEMP_DIR}
fi

# Clean temporary directory
rm -f ${TEMP_DIR}/*

echo "Training ANNs with the following parameters:"
echo "Rounds: ${ROUNDS}"
echo "Generators: ${GENERATORS_NAMES}"
echo "Dimensions: ${GENERATORS_d}"
echo ""

sleep 2

# Create a unique test set for every generator and dimension
for g in ${GENERATORS_NAMES}
do
    for d in ${GENERATORS_d}
    do
        GEN_PATH=${GENERATORS_DIR}/${g}

        ${GEN_PATH} ${TOTAL_TEST} ${d} ${GENERATORS_C} ${TEMP_DIR}/${TEMP_STEM}_${g}_${d} > /dev/null
        mv ${TEMP_DIR}/${TEMP_STEM}_${g}_${d}.data ${TEMP_DIR}/${TEMP_STEM}_${g}_${d}.test
        rm ${TEMP_DIR}/${TEMP_STEM}_${g}_${d}.names
    done
done

# Run the training in parallel.
parallel run_training ::: ${GENERATORS_NAMES} ::: ${GENERATORS_d} ::: $(seq ${ROUNDS})

