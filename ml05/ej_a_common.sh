#!/bin/bash

BAYES_PATH=../ml03/resources/nb_n
C45_PATH=../ml01/c4.5r8/Src/c4.5
SVM_PATH=./resources/svm.py
KFOLDS_PATH=./resources/kfolds.py
FILE_STEM=ej_a
TEMP_DIR=temp_a
# 1^i with i in [-5,5]
PARAM_C="0.00001 0.0001 0.001 0.01 0.1 1.0 10.0 100.0 1000.0 10000.0"
# 1^i with i in [-9,3]
PARAM_GAMMA="0.000000001 0.00000001 0.0000001 0.000001 0.00001 0.0001 0.001 0.01 0.1 1.0 10.0 100.0 1000.0"
DATASET_PATH=resources/heladas
FOLDS=10
METHODS="svml svmr dt nbc"

create_nbfile ()
{
    if [ $# -le 7 ]; then
        echo "Not enough parameters to create nbfile."
        exit
    fi

    # Number of inputs
    local N_IN=${1}
    # Number of classes
    local N_Class=${2}
    # Number of inputs in the .data file
    local PTOT=${3}
    # Number of inputs to be used in training (the rest are used in validation)
    local PR=${4}
    # Number of inputs in the .test file
    local PTEST=${5}
    # Seed for the RNG
    local SEED=${6}
    # Verbosity level
    local CONTROL=${7}
    # Filename for the nb file
    local FILE=${8}

    rm -f ${FILE}

    echo ${N_IN} >>${FILE}
    echo ${N_Class} >>${FILE}
    echo ${PTOT} >>${FILE}
    echo ${PR} >>${FILE}
    echo ${PTEST} >>${FILE}
    echo ${SEED} >>${FILE}
    echo ${CONTROL} >>${FILE}
}
export -f create_nbfile

# Generate a 4-byte unsigned random number greater than 0
gen_rand ()
{
    od -vAn -N4 -tu4 < /dev/urandom | awk '{print 1 + $1}'
}
export -f gen_rand
