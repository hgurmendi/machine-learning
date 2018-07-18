#!/usr/bin/python3

'''
Receives a data file and a number of folds as input, and generates
.test and .data files for every fold.
'''

import argparse
import random

def genFold(data, i):
    foldLen = len(data) // K

    l, r = i * foldLen, (i + 1) * foldLen

    print('*** Generating fold with test set extracted from [', l, ',', r, ') ***')

    test = data[l:r]

    train = data[:]
    del train[l:r]

    return test, train

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument('-f', '--folds', help='number of folds to generate', required=True)
parser.add_argument('-i', '--input', help='input data file (without the .data suffix)', required=True)
parser.add_argument('-v', '--verbose', help='print the contents of each fold', default=False, action='store_true')
args = parser.parse_args()

K = int(args.folds)
FILE = args.input
VERBOSE = args.verbose

print('*** Creating', K, 'folds from file', FILE + '.data', '***')

with open(FILE + '.data', mode='r') as f:
    content = f.readlines()

f.close()
 
content = [x.strip() for x in content]

print('*** Number of objects:', len(content), '***')

if VERBOSE:
    print('****** File contents (unshuffled): ******')

    for line in content:
        print('******', line, '******')

# Shuffle content
random.shuffle(content)

if VERBOSE:
    print('****** File contents (shuffled): ******')

    for line in content:
        print('******', line, '******')

# Write each fold to the corresponding files
for i in range(K):
    test, train = genFold(content, i)

    testFile = FILE + '_' + str(i) + '.test'
    trainFile = FILE + '_' + str(i) + '.data'

    print('*** Writing fold', i, 'test file (', testFile, ') ***')
    with open(testFile, mode='w') as f:
        for line in test:
            f.write(line + '\n')

            if VERBOSE:
                print('******', line, '******')

        f.close()

    print('*** Writing fold', i, 'train file (', trainFile, ') ***')
    with open(trainFile, mode='w') as f:
        for line in train:
            f.write(line + '\n')

            if VERBOSE:
                print('******', line, '******')

        f.close()

