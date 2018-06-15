#!/bin/bash

. ./ej03_common.sh

./ej03_gen.sh

./ej03_train_ann.sh
./ej03_train_bayes.sh

./ej03_plot.sh

