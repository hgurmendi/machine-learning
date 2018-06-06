#!/bin/sh

NB_PATH=./resources/nb_n
FILE_STEM=ej02
TEST_SIZE=10000
TRAIN_SIZE=250
GENERATORS_DIR=../ml00
GENERATORS="diagonal parallel"
GENERATIONS=20
TEMP_DIR=temp02
PARAM_C=0.78
PARAM_d="2 4 8 16 32"

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
