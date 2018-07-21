#!/bin/bash

. ./ej_a_common.sh

./ej_a_gen.sh
./ej_a_calc.sh
./ej_a_calc.R ${TEMP_DIR}/${FILE_STEM}.errors ${TEMP_DIR}/${FILE_STEM}.csv

