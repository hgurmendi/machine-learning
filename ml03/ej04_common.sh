#!/bin/bash

NB_PATH=./resources/nb_n_bins
FILE_STEM=ej04
TEST_SIZE_ELIPSES=2000
TOTAL_SIZE_ELIPSES=1000
VALIDATION_SIZE_ELIPSES=$(expr ${TOTAL_SIZE_ELIPSES} / 10)
BIN_SIZES_ELIPSES=$(seq 1 100)
TEST_SIZE_SPIRALS=2000
TOTAL_SIZE_SPIRALS=1000
VALIDATION_SIZE_SPIRALS=$(expr ${TOTAL_SIZE_SPIRALS} / 10)
BIN_SIZES_SPIRALS=$(seq 1 100)
GENERATOR=../ml00/spirals
TEMP_DIR=temp04
DATASET_DIR=resources
DATASET_STEM=dos_elipses
PLOTTER_PATH=./ej04_plotter.R

create_nbfile ()
{
    if [ $# -le 8 ]; then
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
    local N_BINS=${8}
    # Number of bins
    local FILE=${9}

    rm -f ${FILE}

    echo ${N_IN} >>${FILE}
    echo ${N_Class} >>${FILE}
    echo ${PTOT} >>${FILE}
    echo ${PR} >>${FILE}
    echo ${PTEST} >>${FILE}
    echo ${SEED} >>${FILE}
    echo ${CONTROL} >>${FILE}
    echo ${N_BINS} >>${FILE}
}
export -f create_nbfile


# Generate a 4-byte unsigned random number greater than 0
gen_rand ()
{
    od -vAn -N4 -tu4 < /dev/urandom | awk '{print 1 + $1}'
}
export -f gen_rand
