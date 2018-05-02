#!/bin/sh

set -x

. ./ej06_common.sh

./ej06_gen.sh
./ej06_calc.sh

./ej06_plot_errors.R ${TEMP_DIR}/${FILE_STEM}_parallel.errors ${TEMP_DIR}/${FILE_STEM}_diagonal.errors

