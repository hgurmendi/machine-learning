#!/bin/sh

set -x

. ./ej05_common.sh

./ej05_gen.sh
./ej05_calc.sh

./ej05_plot_errors.R ${TEMP_DIR}/${FILE_STEM}_parallel.errors ${TEMP_DIR}/${FILE_STEM}_diagonal.errors
