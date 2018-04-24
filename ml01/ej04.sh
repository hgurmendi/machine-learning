#!/bin/sh

FILE_STEM=ej04
C45_PATH=./c4.5r8/Src/c4.5
TEST_SIZE=10000
TRAIN_SIZES="150 600 3000"
GEN_PATH=../ml00/spirals
TEMP_DIR=temp04
PLOTTER_PATH=./plotter.R

# Clean previous work
if [ ! -d "${TEMP_DIR}" ]; then
    mkdir ${TEMP_DIR}
fi

rm ${TEMP_DIR}/*

STEM_PATH=${TEMP_DIR}/${FILE_STEM}

# Generate test set
echo "Generating test set of size ${TEST_SIZE}"
${GEN_PATH} ${TEST_SIZE} ${TEMP_DIR}/${FILE_STEM}

mv ${STEM_PATH}.data ${STEM_PATH}.test
rm ${STEM_PATH}.names

# Generate training sets for the requested sizes
for n in ${TRAIN_SIZES}
do
    echo "Generating training set of size ${n}"
    
    ${GEN_PATH} ${n} ${STEM_PATH}_${n}

    # Symlink to the actual test set (which is shared between every training
    # set)
    ln -s ${FILE_STEM}.test ${STEM_PATH}_${n}.test

    echo "Running c4.5 for the training set of size ${n}"
    ${C45_PATH} -f ${STEM_PATH}_${n} -u

    # Generate plots for the training and prediction sets
    ${PLOTTER_PATH} ${STEM_PATH}_${n} data
    ${PLOTTER_PATH} ${STEM_PATH}_${n} prediction
done

