#!/bin/sh

# See `help set`
set -x
# set -v

# Load parameters for exercise 6
. ./ej06_common.sh

for g in ${GENERATORS}
do
    echo "C,TestEBP,TestEAP,BayesERR" > ${TEMP_DIR}/${FILE_STEM}_${g}.errors

    for c in ${PARAM_C}
    do
        STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}_${c}

        echo "Training ${STEM_PATH}..."

        rm -f ${STEM_PATH}.raw

        for i in $(seq ${GENERATIONS})
        do
            echo "*** Training ${STEM_PATH}_${i}..."

            # Generate decision tree for the current generation and redirect
            # its output to ${STEM_CURRENT}_${i}.output
            ${C45_PATH} -f ${STEM_PATH}_${i} -u > ${STEM_PATH}_${i}.output

            # Get every line of the output that contains the sequence "<<"
            # and append it to ${STEM_CURRENT}.raw for future processing
            grep "<<" ${STEM_PATH}_${i}.output >> ${STEM_PATH}.raw

            if [ "${g}" = "diagonal" ]
            then
                BAYES=./ej06_bayes_diagonal.R
            else
                BAYES=./ej06_bayes_parallel.R
            fi
            
            ${BAYES} ${STEM_PATH}_${i}.data >> ${STEM_PATH}.bayes
        done

        echo "Gathering data for ${STEM_PATH}..."

        # awk -F "[()]" indicates that fields are separated by the characters '(' and ')'.
        # use gsub to remove the trailing % from the necessary percentage field.
        
        # Error percentage

        # Error before pruning
        cat ${STEM_PATH}.raw | awk -F "[()]" '{gsub(/(%| )/,""); print $2}' | paste -d "," - - >> ${STEM_PATH}.ebp
        # Every line in ${STEM_PATH}.ebp has the following format:
        # <TrainingErrorPercentage>,<TestErrorPercentage>

        # Error after pruning
        cat ${STEM_PATH}.raw | awk -F "[()]" '{gsub(/(%| )/,""); print $4}' | paste -d "," - - >> ${STEM_PATH}.eap
        # Every line in ${STEM_PATH}.eap has the following format:
        # <TrainingErrorPercentage>,<TestErrorPercentage>

        # Get error averages
        # TRAIN_EBP=$(cat ${STEM_PATH}.ebp | awk -F',' '{acum+=$1; ++n} END {print acum/n}')
        TEST_EBP=$(cat ${STEM_PATH}.ebp | awk -F',' '{acum+=$2; ++n} END {print acum/n}')
        # TRAIN_EAP=$(cat ${STEM_PATH}.eap | awk -F',' '{acum+=$1; ++n} END {print acum/n}')
        TEST_EAP=$(cat ${STEM_PATH}.eap | awk -F',' '{acum+=$2; ++n} END {print acum/n}')
        BAYES_ERR=$(cat ${STEM_PATH}.bayes | awk -F',' '{acum+=$1; ++n} END {print acum/n}')

        echo "${c},${TEST_EBP},${TEST_EAP},${BAYES_ERR}" >> ${TEMP_DIR}/${FILE_STEM}_${g}.errors
    done
done
