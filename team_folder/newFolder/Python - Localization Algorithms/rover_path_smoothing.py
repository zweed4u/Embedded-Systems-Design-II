#!/usr/bin/python

from copy import deepcopy

def printpaths(path,newpath):
    for old,new in zip(path,newpath):
        print '['+ ', '.join('%.3f'%x for x in old) + \
               '] -> ['+ ', '.join('%.3f'%x for x in new) +']'

# Don't modify path inside your function.
path = [[6, 4],
        [5, 4],
        [5, 3],
        [4, 3],
        [4, 2],
        [4, 1],
        [4, 0],
        [3, 0],
        [2, 0],
        [1, 0],
        [1, 1],
        [1, 2],
        [1, 3],
        [0, 3]]

def smooth(path, weight_data = 0.5, weight_smooth = 0.1, tolerance = 0.000001):
    newpath = deepcopy(path)
    change = tolerance
    while change >= tolerance:
        change = 0.
        for i in range(1, len(path)-1):
            for j in range(len(path[0])):
                aux = newpath[i][j]
                newpath[i][j] += weight_data * (path[i][j] - newpath[i][j])
                newpath[i][j] += weight_smooth * (newpath[i-1][j] + newpath[i+1][j] - (2. * newpath[i][j]))
                change += abs(aux - newpath[i][j])
    return newpath

printpaths(path,smooth(path))
