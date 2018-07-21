#!/bin/bash

. ./ej_a_common.sh

${SVM_PATH} -k linear -i ${TEMP_DIR}/${FILE_STEM}_0_svml -C ${PARAM_C} >${TEMP_DIR}/${FILE_STEM}_0_svml.output
${SVM_PATH} -k rbf -i ${TEMP_DIR}/${FILE_STEM}_0_svmr -C ${PARAM_C} -g ${PARAM_GAMMA} >${TEMP_DIR}/${FILE_STEM}_0_svmr.output

LINEAR_MIN_C=$(cat ${TEMP_DIR}/${FILE_STEM}_0_svml.output | grep "MIN C" | awk -F ': ' '{print $2}')

RBF_MIN_C=$(cat ${TEMP_DIR}/${FILE_STEM}_0_svmr.output | grep "MIN C" | awk -F ': ' '{print $2}')
RBF_MIN_G=$(cat ${TEMP_DIR}/${FILE_STEM}_0_svmr.output | grep "MIN GAMMA" | awk -F ': ' '{print $2}')

echo "LINEAR_MIN_C = ${LINEAR_MIN_C}"
echo "RBF_MIN_C = ${RBF_MIN_C}"
echo "RBF_MIN_G = ${RBF_MIN_G}"

for i in $(seq 0 1 $(expr ${FOLDS} - 1))
do
    STEM=${TEMP_DIR}/${FILE_STEM}_${i}
    
    echo "*** Round ${TEMP_DIR}/${FILE_STEM}_${i} ***"

    ${SVM_PATH} -k linear -i ${STEM}_svml -C ${LINEAR_MIN_C} >${STEM}_svml.output

    # sleep 1

    ${SVM_PATH} -k rbf -i ${STEM}_svmr -C ${RBF_MIN_C} -g ${RBF_MIN_G} >${STEM}_svmr.output

    # sleep 1

    ${C45_PATH} -f ${STEM}_dt -u >${STEM}_dt.output
   
    # sleep 1

    ${BAYES_PATH} ${STEM}_nbc >${STEM}_nbc.output

    # sleep 3
done

echo "Fold, svml, svmr, dt, nbc" >${TEMP_DIR}/${FILE_STEM}.errors

for i in $(seq 0 1 $(expr ${FOLDS} - 1))
do
    STEM=${TEMP_DIR}/${FILE_STEM}_${i}

    SVML=$(cat ${STEM}_svml.output | grep "TEST ERROR" | awk -F ': ' '{print $2}')
    SVMR=$(cat ${STEM}_svmr.output | grep "TEST ERROR" | awk -F ': ' '{print $2}')
    DT=$(cat ${STEM}_dt.output | grep "<<" | awk -F "[()]" '{gsub(/(%| )/,""); if (NR==2) print $4}')
    NBC=$(cat ${STEM}_nbc.output | grep "Test" | awk -F ':' '{gsub(/(%| )/,""); print$2}')

    echo "${i}, ${SVML}, ${SVMR}, ${DT}, ${NBC}" >>${TEMP_DIR}/${FILE_STEM}.errors
done


