#!/bin/sh

FILE_STEM=ej04
C45_PATH=./c4.5
TEST_SIZE=10000
TRAIN_SIZES="150 600 3000"
GEN_PATH=./spirals
TEMP_DIR=temp
PLOTTER_PATH=./plotter.R

rm ${TEMP_DIR}/*

STEM_PATH=${TEMP_DIR}/${FILE_STEM}

echo "Generando conjunto de test de tamaño ${TEST_SIZE}"
${GEN_PATH} ${TEST_SIZE} ${TEMP_DIR}/${FILE_STEM}

mv ${STEM_PATH}.data ${STEM_PATH}.test
rm ${STEM_PATH}.names

for n in ${TRAIN_SIZES}
do
    echo "Generando conjunto de entrenamiento de tamaño ${n}"
    
    ${GEN_PATH} ${n} ${STEM_PATH}_${n}

    # Creo un link simbólico al conjunto de test (ya que es el mismo para todos
    # los conjuntos de entrenamiento)
    ln -s ${FILE_STEM}.test ${STEM_PATH}_${n}.test

    echo "Corriendo c4.5 para el conjunto de entrenamiento de tamaño ${n}"
    ${C45_PATH} -f ${STEM_PATH}_${n} -u

    # Genero gráficas para los conjuntos de entrenamiento y sus predicciones
    ${PLOTTER_PATH} ${STEM_PATH}_${n} data
    ${PLOTTER_PATH} ${STEM_PATH}_${n} prediction
done

