#!/bin/sh

FILE_STEM=ej05
C45_PATH=./c4.5
TEST_SIZE=10000
TRAIN_SIZES="125 250 500 1000 2000 4000"
GEN_DIAG_PATH=./diagonal
GEN_PARA_PATH=./parallel
GENERATORS="diagonal parallel"
TEMP_DIR=temp05
PLOTTER_PATH=./plotter.R

PARAM_C=0.78
PARAM_d=2

# rm ${TEMP_DIR}/*
# 
# STEM_PATH=${TEMP_DIR}/${FILE_STEM}
# 
# echo "Generando conjunto de test de tamaño ${TEST_SIZE}"
# ${GEN_PATH} ${TEST_SIZE} ${TEMP_DIR}/${FILE_STEM}
# 
# mv ${STEM_PATH}.data ${STEM_PATH}.test
# rm ${STEM_PATH}.names
# 
# for n in ${TRAIN_SIZES}
# do
#     echo "Generando conjunto de entrenamiento de tamaño ${n}"
#     
#     ${GEN_PATH} ${n} ${STEM_PATH}_${n}
# 
#     # Creo un link simbólico al conjunto de test (ya que es el mismo para todos
#     # los conjuntos de entrenamiento)
#     ln -s ${FILE_STEM}.test ${STEM_PATH}_${n}.test
# 
#     echo "Corriendo c4.5 para el conjunto de entrenamiento de tamaño ${n}"
#     ${C45_PATH} -f ${STEM_PATH}_${n} -u
# 
#     # Genero gráficas para los conjuntos de entrenamiento y sus predicciones
#     ${PLOTTER_PATH} ${STEM_PATH}_${n} data
#     ${PLOTTER_PATH} ${STEM_PATH}_${n} prediction
# done

rm ${TEMP_DIR}/*

for g in ${GENERATORS}
do
    echo "Generando conjunto de test de tamaño ${TEST_SIZE} para el generador ${g}"

    GEN_PATH=./${g}

    STEM_PATH=${TEMP_DIR}/${FILE_STEM}_${g}
    
    ${GEN_PATH} ${TEST_SIZE} ${PARAM_d} ${PARAM_C} ${STEM_PATH} 
    mv ${STEM_PATH}.data ${STEM_PATH}.test
    rm ${STEM_PATH}.names

    for n in ${TRAIN_SIZES}
    do
        
    
    done
done
