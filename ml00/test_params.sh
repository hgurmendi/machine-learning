#!/bin/sh

if [ $# -ne 5 ]; then
    echo "USAGE: ${0} diagonal|parallel n d C dataset_stem"
    exit
fi

GENERATOR=${1}
STATS=../dataset_stats.R
FILESTEM=${5}
n=${2}
d=${3}
C=${4}

echo "*************"
echo "Generando usando ${GENERATOR} con n=${n}, d=${d}, C=${C}"
echo "*************"
echo ""

./${GENERATOR} ${n} ${d} ${C} ${FILESTEM}

echo ""
echo "*************"
echo "Calculando valores característicos del dataset"
echo "*************"
echo ""
${STATS} ${FILESTEM}.data | cat

rm ${FILESTEM}.data ${FILESTEM}.names

