#!/bin/bash

. ./ej02_common.sh

#./ej02_gen.sh
#./ej02_calc.sh

./ej02_plot.R resources/trees_diagonal.errors resources/trees_parallel.errors resources/anns_errors.mde ${TEMP_DIR}/${FILE_STEM}_diagonal.errors ${TEMP_DIR}/${FILE_STEM}_parallel.errors

