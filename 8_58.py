# -- coding: utf-8 --
from __future__ import division

import numpy as np
def calculate_estimate(x2, x3, n=190):
    return (2*x3 + x2)/(2*n)

from bisect import bisect
from random import random

# http://stackoverflow.com/questions/4437250/choose-list-variable-given-probability-of-each-variable
def select_element(P):
    cdf = [P[0]]
    for i in xrange(1, len(P)):
        cdf.append(cdf[-1] + P[i])

    return bisect(cdf,random())

def generate_sample(p1, p2, p3, n = 190):
    x1 = x2 = x3 = 0
    for _ in range(n):
        idx = select_element([p1, p2, p3])
        if idx == 0:
            x1 += 1
        elif idx == 1:
            x2 += 1
        elif idx == 2:
            x3 += 1
    return x1, x2, x3

def get_std(p1, p2, p3, n, N):
    lst = []
    for i in range(N):
        (x1, x2, x3) = generate_sample(p1, p2, p3, n)
        theta = calculate_estimate(x2, x3, n)
        lst.append(theta)
    return np.std(lst)

def get_quantiles(p1, p2, p3, n, N, j_lst):
    lst = []
    for i in range(N):
        (x1, x2, x3) = generate_sample(p1, p2, p3, n)
        theta = calculate_estimate(x2, x3, n)
        lst.append(theta)
    sorted_lst = sorted(lst)
    return [sorted_lst[j] for j in j_lst]

p1 = 0.053
p2 = 0.355
p3 = 0.59
n = 190
N = 1000

# print get_quantiles(p1, p2, p3, n, N, [5, 995])

console = []
