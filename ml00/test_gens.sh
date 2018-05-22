#!/bin/sh

GS="diagonal parallel"
NS="250 500 1000"
DS="2 4 8"
CS="0.7 1.4 2.1"
DUMPFILE=testdump
TEMPFILE=tempfile

set -x

rm -f ${DUMPFILE}

for g in ${GS}
do
    for n in ${NS}
    do
        for d in ${DS}
        do
            for C in ${CS}
            do
                ./test_params.sh ${g} ${n} ${d} ${C} ${TEMPFILE} >> ${DUMPFILE}
            done
        done
    done
done

