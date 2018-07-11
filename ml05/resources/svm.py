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
parser.add_argument("-i", "--input", help="input file", default='test.data')
parser.add_argument("-f", "--folds", help="number of folds", default=10)
parser.add_argument("-v", "--verbosity", help="verbosity level, 0 for no messages, 1 for messages", default=0)
args = parser.parse_args()

INPUT = args.input
FOLDS = int(args.folds)
VERBOSITY = int(args.verbosity)

#quit()

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
inputsShuf, classesShuf = shuffle(inputs, classes)

if VERBOSITY > 0:
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
# SVM fitting
##########################################################################

#clf = svm.SVC(kernel='linear')
#clf.fit(inputs, classes)
#print(clf)


