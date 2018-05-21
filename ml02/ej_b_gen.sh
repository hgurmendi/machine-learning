#!/bin/bash

. ./ej_b_common.sh

run_training () {
    # Number of hidden neurons
    local HIDDEN_NEURONS=$1
    # Index of the current run
    local INDEX=$2
    # Filename for the netfile
    local FILESTEM=${TEMP_DIR}/${TEMP_STEM}_${HIDDEN_NEURONS}_${INDEX}
    # Random seed
    local SEED=$(gen_rand)

    echo "**** Running training with hidden_neurons=${HIDDEN_NEURONS}, seed=${SEED}, round=${INDEX}"
    create_netfile 2 ${HIDDEN_NEURONS} 1 ${TOTAL_TRAIN} ${TRAIN} ${TEST} ${EPOCHS} ${LR} ${MU} ${RECORD_RATE} 0 ${SEED} ${VERBOSITY} ${FILESTEM}.net

    ln -s ${TEMP_STEM}.data ${FILESTEM}.data
    ln -s ${TEMP_STEM}.test ${FILESTEM}.test

    ${BP} ${FILESTEM} > ${FILESTEM}.output

    echo "**** Finished running training with hidden_neurons=${HIDDEN_NEURONS}, seed=${SEED}, round=${INDEX}"
}
export -f run_training

# Create temporary directory if it doesn't exist
if [ ! -d ${TEMP_DIR} ];
then
    mkdir ${TEMP_DIR}
fi

# Clean temporary directory
rm -f ${TEMP_DIR}/*

# Create train and test datasets and place them in the datasets folder
${SPIRALS} ${TOTAL_TRAIN} ${DATASETS_DIR}/${TEMP_STEM}_train
${SPIRALS} ${TEST} ${DATASETS_DIR}/${TEMP_STEM}_test

# Copy train and test datasets to the temporary folder
cp ${DATASETS_DIR}/${TEMP_STEM}_train.data ${TEMP_DIR}/${TEMP_STEM}.data
cp ${DATASETS_DIR}/${TEMP_STEM}_test.data ${TEMP_DIR}/${TEMP_STEM}.test

echo "Training ANNs with the following parameters:"
echo "Rounds: ${ROUNDS}"
echo "Learning rate: ${LR}"
echo "Momentum: ${MU}"
echo "Neurons in hidden layer: ${HIDDEN_NEURONS}"
echo ""

# Run the training in parallel.
parallel run_training ::: ${HIDDEN_NEURONS} ::: $(seq ${ROUNDS})
