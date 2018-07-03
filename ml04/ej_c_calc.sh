#!/bin/bash

. ./ej_c_common.sh

run_knn () {
    # Name of the generator
    local GEN=${1}   
    # Number of dimensions
    local DIM=${2}
    # Run index
    local RUN=${3}
    # Filestem for the run's files
    local STEM=${TEMP_DIR}/${FILE_STEM}_${GEN}_${DIM}_${RUN}

    echo "*** Training ${STEM}..."
    
    ${KNN_PATH} ${STEM} >${STEM}.output

    grep ">>>" ${STEM}.output >${STEM}.minerror

    awk '{ print $2 }' ${STEM}.minerror >> ${TEMP_DIR}/${FILE_STEM}_${GEN}_${DIM}.tre
    awk '{ print $3 }' ${STEM}.minerror >> ${TEMP_DIR}/${FILE_STEM}_${GEN}_${DIM}.vae
    awk '{ print $4 }' ${STEM}.minerror >> ${TEMP_DIR}/${FILE_STEM}_${GEN}_${DIM}.tee

    echo "*** Finished training ${STEM}..."
}
export -f run_knn

rm -f *.tre *.vae *.tee

echo "Training KNN with the following parameters:"
echo "Generators: ${GENERATORS}"
echo "Dimensions: ${PARAM_d}"
echo "Rounds: ${GENERATIONS}"
echo ""

source `which env_parallel.bash`

# TEMP_DIR=${TEMP_DIR} FILE_STEM=${FILE_STEM} parallel run_knn ::: ${GENERATORS} ::: ${PARAM_d} ::: $(seq ${GENERATIONS})
env_parallel run_knn ::: ${GENERATORS} ::: ${PARAM_d} ::: $(seq ${GENERATIONS})


echo "Gathering data..."

for g in ${GENERATORS}
do
    echo "d,Train,Validation,Test" > ${TEMP_DIR}/${FILE_STEM}_${g}.avgerr

    for d in ${PARAM_d}
    do
        STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${d}

        echo "Gathering data for ${STEM_PATH}..."

        TRAIN_ERR=$(cat ${STEM_PATH}.tre | awk '{acum+=$1; ++n} END {print acum/n}')
        VALIDATION_ERR=$(cat ${STEM_PATH}.vae | awk '{acum+=$1; ++n} END {print acum/n}')
        TEST_ERR=$(cat ${STEM_PATH}.tee | awk '{acum+=$1; ++n} END {print acum/n}')
        
        echo "${d},${TRAIN_ERR},${VALIDATION_ERR},${TEST_ERR}" >> ${TEMP_DIR}/${FILE_STEM}_${g}.avgerr
    done
done

# for g in ${GENERATORS}
# do
#     rm -f ${TEMP_DIR}/${FILE_STEM}_${g}.avgerr
# 
#     echo "d,Train,Validation,Test" > ${TEMP_DIR}/${FILE_STEM}_${g}.avgerr
# 
#     for d in ${PARAM_d}
#     do
#         STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${d}
# 
#         echo "Training ${STEM_PATH}..."
# 
#         rm -f ${STEM_PATH}.tre
#         rm -f ${STEM_PATH}.vae
#         rm -f ${STEM_PATH}.tee
# 
#         for i in $(seq ${GENERATIONS})
#         do
#             echo "*** Training ${STEM_PATH}_${i}..."
# 
#             ${KNN_PATH} ${STEM_PATH}_${i} >${STEM_PATH}_${i}.output
# 
#             grep ">>>" ${STEM_PATH}_${i}.output >${STEM_PATH}_${i}.minerror
# 
#             awk '{ print $2 }' ${STEM_PATH}_${i}.minerror >> ${STEM_PATH}.tre
#             awk '{ print $3 }' ${STEM_PATH}_${i}.minerror >> ${STEM_PATH}.vae
#             awk '{ print $4 }' ${STEM_PATH}_${i}.minerror >> ${STEM_PATH}.tee
#         done
# 
#         echo "Gathering data for ${STEM_PATH}..."
# 
#         TRAIN_ERR=$(cat ${STEM_PATH}.tre | awk '{acum+=$1; ++n} END {print acum/n}')
#         VALIDATION_ERR=$(cat ${STEM_PATH}.vae | awk '{acum+=$1; ++n} END {print acum/n}')
#         TEST_ERR=$(cat ${STEM_PATH}.tee | awk '{acum+=$1; ++n} END {print acum/n}')
#         
#         echo "${d},${TRAIN_ERR},${VALIDATION_ERR},${TEST_ERR}" >> ${TEMP_DIR}/${FILE_STEM}_${g}.avgerr
#     done
# done
