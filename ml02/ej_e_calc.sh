#!/bin/bash

. ./ej_e_common.sh

median_discrete_error() {
    local GEN=$1
    local DIM=$2

    ERROR=$(grep -h "discreto" ${TEMP_DIR}/${TEMP_STEM}_${GEN}_${DIM}_*.output |    # get every line from inputs with text "discreto"
            awk -F ':' '{gsub(/(%| )/,""); print $2}' |                             # get the percentage without the "%" character
            sort -n |                                                               # sort the numbers in ascending orders
            awk '{ a[i++] = $1; } END { print a[int(i/2)] }')                       # get the median of those numbers

    echo ${ERROR}
}

for g in ${GENERATORS_NAMES}
do
    for d in ${GENERATORS_d}
    do
        ERR=$(median_discrete_error ${g} ${d})

        echo "${g}, ${d}, ${ERR}" >> ${TEMP_DIR}/${TEMP_STEM}.mde
    done
done
