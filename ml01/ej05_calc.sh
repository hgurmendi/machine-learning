#!/bin/sh

C45_PATH=./c4.5r8/Src/c4.5
FILE_STEM=ej05
TEST_SIZE=10000
TRAIN_SIZES="125 250 500 1000 2000 4000"
GENERATORS_DIR=../ml00
GENERATORS="diagonal parallel"
GENERATIONS=20
TEMP_DIR=temp05

for g in ${GENERATORS}
do
    for n in ${TRAIN_SIZES}
    do
        for i in $(seq 20)
        do
            STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${n}_${i}

            echo "Processing ${STEM_PATH}"

            # Generate decision tree for the current file and redirect its
            # output to $STEM_CURRENT.output
            ${C45_PATH} -f ${STEM_PATH} -u >> ${STEM_PATH}.output

            # Get the lines of the output that contain the sequence "<<" and
            # dump them to $STEM_CURRENT.raw for further processing
            grep "<<" ${STEM_PATH}.output >> ${STEM_PATH}.raw
        done
    done
done
