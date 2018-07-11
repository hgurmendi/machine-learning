#!/usr/bin/python3

FOLDS=10
INPUTS='heladas.data'

import csv
from sklearn import svm

inputs = []
classes = []

with open(INPUTS, newline='') as f:
    reader = csv.reader(f)
    for row in reader:
        inputs.append(list(map(lambda x : float(x), row[:-1])))
        classes.append(int(row[-1]))

#for i in range(len(inputs)):
#    print(inputs[i], classes[i])

clf = svm.SVC()
clf.fit(inputs, classes)
print(clf)


