#!/bin/bash

. ./ej_c_common.sh

K=1 ./ej_c_gen.sh
./ej_c_calc.sh

./ej_c_plot.R resources/trees_diagonal.errors resources/trees_parallel.errors resources/anns_errors.mde resources/nb_diagonal.errors resources/nb_parallel.errors ${TEMP_DIR}/${FILE_STEM}_diagonal.avgerr ${TEMP_DIR}/${FILE_STEM}_parallel.avgerr

mv ej_c.png ej_c_k1.png

K=0 ./ej_c_gen.sh
./ej_c_calc.sh

./ej_c_plot.R resources/trees_diagonal.errors resources/trees_parallel.errors resources/anns_errors.mde resources/nb_diagonal.errors resources/nb_parallel.errors ${TEMP_DIR}/${FILE_STEM}_diagonal.avgerr ${TEMP_DIR}/${FILE_STEM}_parallel.avgerr

mv ej_c.png ej_c_kmin.png

