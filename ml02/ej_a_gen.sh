#!/bin/bash

. ./ej_a_common.sh

run_training () {
    # Learning rate for the current run
    local LR=$1
    # Momentum for the current run
    local MU=$2
    # Index of the current run
    local INDEX=$3
    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}_${LR}_${MU}_${INDEX}
    # Random seed
    local SEED=$(gen_rand)

    echo "**** Running training with LR=${LR}, MU=${MU}, round=${INDEX}"
    create_netfile 2 ${HIDDEN_NEURONS} 1 ${TOTAL_TRAIN} ${VALIDATION} ${TEST} ${EPOCHS} ${LR} ${MU} ${RECORD_RATE} 0 ${SEED} ${VERBOSITY} ${FILESTEM}.net

    ln -s ${TEMP_STEM}.data ${FILESTEM}.data
    ln -s ${TEMP_STEM}.test ${FILESTEM}.test

    ${BP} ${FILESTEM} > ${FILESTEM}.output

    echo "**** Finished running training with LR=${LR}, MU=${MU}, Seed=${SEED}, round=${INDEX}"
}
export -f run_training

# Create temporary directory if it doesn't exist
if [ ! -d ${TEMP_DIR} ];
then
    mkdir ${TEMP_DIR}
fi

# Clean temporary directory
rm -f ${TEMP_DIR}/*

# Copy .data and .test files from the dataset
cp ${DATASETS_DIR}/dos_elipses.data ${TEMP_DIR}/${TEMP_STEM}.data
cp ${DATASETS_DIR}/dos_elipses.test ${TEMP_DIR}/${TEMP_STEM}.test

echo "Training ANNs with the following parameters:"
echo "Rounds: ${ROUNDS}"
echo "Learning rates: ${LEARNING_RATES}"
echo "Momentums: ${MOMENTUMS}"
echo ""

# Run the training in parallel.
parallel run_training ::: ${LEARNING_RATES} ::: ${MOMENTUMS} ::: $(seq ${ROUNDS})
