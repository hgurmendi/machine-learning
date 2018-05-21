#!/bin/bash

. ./ej_b_common.sh

./ej_b_gen.sh

# Plot every prediction
for HN in ${HIDDEN_NEURONS}
do
    BASENAME=${TEMP_DIR}/${TEMP_STEM}_${HN}_1

    ${DISCRETIZA} ${BASENAME}
    mv ${BASENAME}.predic.d ${BASENAME}.prediction

    ${PLOTTER} ${BASENAME} prediction
done

# Plot the test set
cp ${TEMP_DIR}/${TEMP_STEM}.test ${TEMP_DIR}/${TEMP_STEM}_test.data
${PLOTTER} ${TEMP_DIR}/${TEMP_STEM}_test data
