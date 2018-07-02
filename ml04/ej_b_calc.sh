#!/bin/bash

. ./ej_b_common.sh

#for i in $(seq ${GENERATIONS})
#do
#    STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${i}
#
#    echo "Running ${i}"
#    ${KNN_PATH} ${STEM_PATH} | grep ">>>" >>${STEM_PATH}.minerrors
#    echo "Finished running ${i}"
#done

## Get all minimum errors in a single file:
#cat ${TEMP_DIR}/*.minerrors >${TEMP_DIR}/${FILE_STEM}.errors

awk '{ train+=$2; valid+=$3; test+=$4; n++; }
     END { trainavg=train/n; validavg=valid/n; testavg=test/n; print trainavg, validavg, testavg; }' ${TEMP_DIR}/${FILE_STEM}.errors > ${TEMP_DIR}/${FILE_STEM}.avgerrors


