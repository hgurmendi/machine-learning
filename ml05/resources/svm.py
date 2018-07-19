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
parser.add_argument('-i', '--input', help='input files\' stem (without the .data or .test suffix)', required=True)
parser.add_argument('-v', '--verbose', help='shows detailed output', default=False, action='store_true')
parser.add_argument('-k', '--kernel', help='kernel type (possible values \'rbf\', \'linear\', default \'linear\')', default='linear')
parser.add_argument('-C', nargs='*', help='penalty parameter C of the error term (default 1.0), it can be a list of different C values, in which case it will output the errors for the one with minimum test error', default=['1.0'])
args = parser.parse_args()

INPUT = args.input
VERBOSE = args.verbose
KERNEL = args.kernel
PARAM_C = list(map(lambda x : float(x), args.C))

print('Running Support Vector Machine with the following parameters:')
print('Input stem:', INPUT)
print('Verbosity:', VERBOSE)
print('Kernel:', KERNEL)
print('C:', PARAM_C)
print('')

##########################################################################
# Input parsing
##########################################################################

def parseFile(path):
    """Reads the contents of the CSV file in path and returns two lists consisting of its inputs and classes, respectively."""
    inputs = []
    classes = []

    with open(path, mode='r') as f:
        reader = csv.reader(f)
        for row in reader:
            inputs.append(list(map(lambda x : float(x), row[:-1])))
            classes.append(int(row[-1]))

        return inputs, classes

trainFile = INPUT + '.data'
testFile = INPUT + '.test'

print('Reading train set from', trainFile)
trainInputs, trainClasses = parseFile(trainFile)
if VERBOSE:
    print('Train file contents:')
    
    for i in range(len(trainInputs)):
        print(trainInputs[i], trainClasses[i])

print('Reading test set from', testFile)
testInputs, testClasses = parseFile(testFile)
if VERBOSE:
    print('Test file contents:')
    
    for i in range(len(testInputs)):
        print(testInputs[i], testClasses[i])

##########################################################################
# SVM fitting & error computation
##########################################################################

trainMinError, testMinError = 1e10, 1e10
minC = None

for c in PARAM_C:
    clf = svm.SVC(kernel=KERNEL, C=c)
    
    clf.fit(trainInputs, trainClasses)
    
    trainPredics = clf.predict(trainInputs)
    testPredics = clf.predict(testInputs)
    
    trainMisses, testMisses = 0, 0
    
    for i in range(len(trainPredics)):
        if trainPredics[i] != trainClasses[i]:
            trainMisses = trainMisses + 1
    
    for i in range(len(testPredics)):
        if testPredics[i] != testClasses[i]:
            testMisses = testMisses + 1
    
    trainError = trainMisses / len(trainClasses)
    testError = testMisses / len(testClasses)

    if testError < testMinError:
        trainMinError = trainError
        testMinError = testError
        minC = c

print('C:', minC)
print('TRAIN ERROR:', trainMinError * 100)
print('TEST ERROR:', testMinError * 100)
print('')

