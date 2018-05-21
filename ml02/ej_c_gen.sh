#!/bin/bash

. ./ej_c_common.sh

run_training () {
    # Number of hidden neurons
    local PERCENTAGE_TRAIN=$1
    # Index of the current run
    local INDEX=$2
    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}_${PERCENTAGE_TRAIN}_${INDEX}
    # Random seed
    local SEED=$(gen_rand)
    # Number of data patterns to be used in training, depends on the percentage
    local TRAIN=$(expr 100 '*' ${PERCENTAGE_TRAIN} / 100)

    echo "**** Running training with %_train=${PERCENTAGE_TRAIN}, seed=${SEED}, round=${INDEX}"
    create_netfile 5 40 1 100 ${TRAIN} 2000 20000 0.01 0.3 200 0 ${SEED} 0 ${FILESTEM}.net

    ln -s ${TEMP_STEM}.data ${FILESTEM}.data
    ln -s ${TEMP_STEM}.test ${FILESTEM}.test

    ${BP} ${FILESTEM} > ${FILESTEM}.output

    echo "**** Finished running training with %_train=${PERCENTAGE_TRAIN}, seed=${SEED}, round=${INDEX}"
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
cp ${DATASETS_DIR}/ikeda.data ${TEMP_DIR}/${TEMP_STEM}.data
cp ${DATASETS_DIR}/ikeda.test ${TEMP_DIR}/${TEMP_STEM}.test

echo "Training ANNs with the following parameters:"
echo "Rounds: ${ROUNDS}"
echo "Percentage of training patterns: ${PERCENTAGES_TRAINING}"
echo ""

# Run the training in parallel.
parallel run_training ::: ${PERCENTAGES_TRAINING} ::: $(seq ${ROUNDS})

