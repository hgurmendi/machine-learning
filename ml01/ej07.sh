#!/bin/sh

set -x

. ./ej07_common.sh

./ej07_gen.sh
./ej07_calc.sh

./ej07_plot_errors.R ${TEMP_DIR}/${FILE_STEM}_parallel.errors ${TEMP_DIR}/${FILE_STEM}_diagonal.errors

