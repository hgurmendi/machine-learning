#!/bin/bash

BAYES_PATH=../ml03/nb_n
C45_PATH=../ml01/c4.5r8/Src/c4.5
SVM_PATH=./resources/svm.py
KFOLDS_PATH=./resources/kfolds.py
FILE_STEM=ej_a
TEMP_DIR=temp_a
# 10^i with i in [-5,5]
PARAM_C="0.00001 0.0001 0.001 0.01 0.1 0.4 0.7 1.0 1.5 2.5 4.0 5.0 10.0 100.0 1000.0 10000.0"
# 10^i with i in [-9,3]
PARAM_GAMMA="0.000000001 0.00000001 0.0000001 0.000001 0.00001 0.0001 0.001 0.01 0.1 1.0 10.0 100.0 1000.0"
DATASET_PATH=resources/heladas
FOLDS=10

# Generate a 4-byte unsigned random number greater than 0
gen_rand ()
{
    od -vAn -N4 -tu4 < /dev/urandom | awk '{print 1 + $1}'
}
export -f gen_rand
