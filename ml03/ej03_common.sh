#!/bin/sh

NB_PATH=./resources/nb_n
FILE_STEM=ej03
TEST_SIZE_ELIPSES=2000
TRAIN_SIZE_ELIPSES=500
TEST_SIZE_SPIRALS=2000
TRAIN_SIZE_SPIRALS=2000
GENERATOR=../ml00/spirals
TEMP_DIR=temp03
LR=0.01
MU=0.5
DATASET_STEM=resources/dos_elipses
BP_PATH=../ml02/bin/bp
PLOTTER_PATH=./ej03_plotter.R

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

create_netfile ()
{
    if [ $# -le 13 ]; then
        echo "Not enough parameters to create netfile."
        exit
    fi

    # Neurons in input layer
    local N1=${1}
    # Neurons in hidden layer
    local N2=${2}
    # Neurons in output layer
    local N3=${3}
    # Number of inputs in the .data file
    local PTOT=${4}
    # Number of inputs to be used in training (the rest are used in validation)
    local PR=${5}
    # Number of inputs in the .test file
    local PTEST=${6}
    # Total number of iterations (epochs)
    local ITER=${7}
    # Learning rate
    local ETA=${8}
    # Momentum
    local u=${9}
    # Write error every NERROR iterations
    local NERROR=${10}
    # Initial synapsis file
    local WTS=${11}
    # Seed for the RNG
    local SEED=${12}
    # Verbosity level
    local CONTROL=${13}
    # Filename for the netfile
    local FILE=${14}

    rm -f ${FILE}

    echo ${N1} >>${FILE}
    echo ${N2} >>${FILE}
    echo ${N3} >>${FILE}
    echo ${PTOT} >>${FILE}
    echo ${PR} >>${FILE}
    echo ${PTEST} >>${FILE}
    echo ${ITER} >>${FILE}
    echo ${ETA} >>${FILE}
    echo ${u} >>${FILE}
    echo ${NERROR} >>${FILE}
    echo ${WTS} >>${FILE}
    echo ${SEED} >>${FILE}
    echo ${CONTROL} >>${FILE}
}
export -f create_netfile

# Generate a 4-byte unsigned random number greater than 0
gen_rand ()
{
    od -vAn -N4 -tu4 < /dev/urandom | awk '{print 1 + $1}'
}
export -f gen_rand
