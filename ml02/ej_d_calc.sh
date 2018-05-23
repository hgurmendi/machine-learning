#!/bin/bash

. ./ej_d_common.sh

generate_avg_mse() {
    local GAMMA=$1

    awk '{rows=FNR; cols=NF; for (i = 1; i <= NF; i++) { total[FNR, i] += $i } }
         FILENAME != lastfn { count++; lastfn = FILENAME }
         END { 
                for (i = 1; i <= rows; i++) { 
                    for (j =  1; j <= cols; j++)
                        printf("%s ", total[i, j]/count)
                    
                    printf("\n")
                }
             }' ${TEMP_DIR}/${TEMP_STEM}_${GAMMA}_*.mse > ${TEMP_DIR}/${TEMP_STEM}_${GAMMA}.mse.avg
}

for GAMMA in ${GAMMAS}
do
    generate_avg_mse ${GAMMA}
done
