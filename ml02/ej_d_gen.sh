#!/bin/bash

. ./ej_d_common.sh

run_training () {
    # Number of hidden neurons
    local GAMMA=$1
    # Index of the current run
    local INDEX=$2
    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}_${GAMMA}_${INDEX}
    # Random seed
    local SEED=$(gen_rand)

    echo "**** Running training with gamma=${GAMMA}, seed=${SEED}, round=${INDEX}"
    create_netfile 12 6 1 ${TOTAL_DATAFILE} ${TOTAL_DATAFILE} 107 100000 0.01 0.3 200 0 ${SEED} 0 ${GAMMA} ${FILESTEM}.net

    ln -s ${TEMP_STEM}.data ${FILESTEM}.data
    ln -s ${TEMP_STEM}.test ${FILESTEM}.test

    ${BP} ${FILESTEM} > ${FILESTEM}.output

    echo "**** Finished running training with gamma=${GAMMA}, seed=${SEED}, round=${INDEX}"
}
export -f run_training

# Create temporary directory if it doesn't exist
if [ ! -d ${TEMP_DIR} ];
then
    mkdir ${TEMP_DIR}
fi

# Clean temporary directory
rm -f ${TEMP_DIR}/*

# Copy train and test datasets to the temporary folder
cp ${DATASETS_DIR}/${DATASET_NAME}.data ${TEMP_DIR}/${TEMP_STEM}.data
cp ${DATASETS_DIR}/${DATASET_NAME}.test ${TEMP_DIR}/${TEMP_STEM}.test

echo "Training ANNs with the following parameters:"
echo "Rounds: ${ROUNDS}"
echo "Gammas: ${GAMMAS}"
echo ""

# Run the training in parallel.
parallel run_training ::: ${GAMMAS} ::: $(seq ${ROUNDS})

