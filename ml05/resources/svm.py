#!/usr/bin/python3

import csv
import argparse
from sklearn import svm
from sklearn.model_selection import GroupKFold
from sklearn.utils import shuffle

##########################################################################
# Argument parsing
##########################################################################

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", help="input file (default 'test.data')", default='test.data')
parser.add_argument("-f", "--folds", help="number of folds (default 10)", default=10)
parser.add_argument("-v", "--verbosity", help="verbosity level, 0 for no messages, 1 for messages (default 0)", default=0)
parser.add_argument("-k", "--kernel", help="kernel type (default 'linear')", default='linear')
parser.add_argument("-C", help="Penalty parameter C of the error term (default 1.0)", default=1.0)
args = parser.parse_args()

INPUT = args.input
FOLDS = int(args.folds)
VERBOSITY = int(args.verbosity)
KERNEL = args.kernel
PARAM_C = float(args.C)

print("Running Support Vector Machine with the following parameters:")
print("Input data file: ", INPUT)
print("Verbosity level: ", VERBOSITY)
print("Kernel: ", KERNEL)
print("C: ", PARAM_C)
print("")

##########################################################################
# Input parsing
##########################################################################

inputs = []
classes = []

with open(args.input, newline='') as f:
    reader = csv.reader(f)
    for row in reader:
        inputs.append(list(map(lambda x : float(x), row[:-1])))
        classes.append(int(row[-1]))

# Shuffle inputs:
inputsShuf, classesShuf = shuffle(inputs, classes, random_state=0)

if VERBOSITY > 0:
    print('Inputs:')
    for i in range(len(classesShuf)):
        print(inputsShuf[i], classesShuf[i])

##########################################################################
# K-Folds
##########################################################################

def getSplits(i):
    foldLen = len(inputsShuf) // FOLDS

    l, r = i * foldLen, (i + 1) * foldLen

    inputsValid = inputsShuf[l:r]
    classesValid = classesShuf[l:r]
    
    inputsTrain = inputsShuf[:]
    del inputsTrain[l:r]

    classesTrain = classesShuf[:]
    del classesTrain[l:r]

    return inputsValid, classesValid, inputsTrain, classesTrain

if VERBOSITY > 0:
    for i in range(FOLDS):
        print('******************************')
        print('Fold', i + 1)
        print('******************************')
    
        a, b, c, d = getSplits(i)
    
        print('Validation:')
        for j in range(len(a)):
            print(a[j], b[j])
    
        print('Train:')
        for j in range(len(c)):
            print(c[j], d[j])


##########################################################################
# SVM fitting & error computation
##########################################################################

eT, eV = 0.0, 0.0

for i in range(FOLDS):
    iV, cV, iT, cT = getSplits(i)
    
    clf = svm.SVC(kernel=KERNEL, C=PARAM_C)

    clf.fit(iT, cT)

    pT = clf.predict(iT)
    pV = clf.predict(iV)

    mT, mV = 0, 0

    for j in range(len(pT)):
        if pT[j] == cT[j]:
            mT = mT + 1

    for j in range(len(pV)):
        if pV[j] == cV[j]:
            mV = mV + 1

    eT = eT + (mT / len(pT))
    eV = eV + (mV / len(pV))

eT = 1 - eT / FOLDS
eV = 1 - eV / FOLDS

print("Error en train:", eT)
print("Error en validacion:", eV)
print("")






