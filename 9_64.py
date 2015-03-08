# -- coding: utf-8 --
from __future__ import division
import numpy as np
import scipy.stats as st
import matplotlib.pyplot as plt

m_temp = []
f_temp = []
m_rate = []
f_rate = []
with open("bodytemp.txt") as f:
    next(f)
    for line in f:
        d = line.split(",")
        if int(d[1]) == 1: # male
            m_temp.append(float(d[0]))
            m_rate.append(int(d[2]))
        elif int(d[1]) == 2: # female
            f_temp.append(float(d[0]))
            f_rate.append(int(d[2]))
        else:
            raise NotImplementedError, "Unknown type"

m_temp.sort()
f_temp.sort()
m_rate.sort()
f_rate.sort()

n = len(m_rate)
x = st.norm.ppf([k/(n+1) for k in range(1, n+1)])

# plt.plot(x, m_temp, 'o')
# plt.title("Male Temperature")
# plt.xlabel("Normal quantiles")
# plt.ylabel("Ordered observations")

# plt.plot(x, f_temp, 'o')
# plt.title("Female Temperature")
# plt.xlabel("Normal quantiles")
# plt.ylabel("Ordered observations")
# plt.show()

# plt.plot(x, m_rate, 'o')
# plt.title("Male rate")
# plt.xlabel("Normal quantiles")
# plt.ylabel("Ordered observations")
# plt.show()

plt.plot(x, f_rate, 'o')
plt.title("Female rate")
plt.xlabel("Normal quantiles")
plt.ylabel("Ordered observations")
plt.show()


console = []