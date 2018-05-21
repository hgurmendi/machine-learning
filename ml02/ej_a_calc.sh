#!/bin/bash

. ./ej_a_common.sh

median_discrete_error() {
    local LR=$1
    local MU=$2

    ERROR=$(grep -h "discreto" ${TEMP_DIR}/${TEMP_STEM}_${LR}_${MU}_*.output |  # get every line from inputs with text "discreto"
            awk -F ':' '{gsub(/(%| )/,""); print $2}' |                         # get the percentage without the "%" character
            sort -n |                                                           # sort the numbers in ascending orders
            awk '{ a[i++] = $1; } END { print a[int(i/2)] }')                   # get the median of those numbers

    echo ${ERROR}
}

generate_avg_mse() {
    local LR=$1
    local MU=$2

    awk '{rows=FNR; cols=NF; for (i = 1; i <= NF; i++) { total[FNR, i] += $i } }
         FILENAME != lastfn { count++; lastfn = FILENAME }
         END { 
                for (i = 1; i <= rows; i++) { 
                    for (j =  1; j <= cols; j++)
                        printf("%s ", total[i, j]/count)
                    
                    printf("\n")
                }
             }' ${TEMP_DIR}/${TEMP_STEM}_${LR}_${MU}_*.mse > ${TEMP_DIR}/${TEMP_STEM}_${LR}_${MU}.mse.avg
}

rm -f ${TEMP_DIR}/${TEMP_STEM}.mde

for LR in ${LEARNING_RATES}
do
    for MU in ${MOMENTUMS}
    do
        ERR=$(median_discrete_error ${LR} ${MU})

        echo "${LR}, ${MU}, ${ERR}" >> ${TEMP_DIR}/${TEMP_STEM}.mde

        generate_avg_mse ${LR} ${MU}
    done
done
