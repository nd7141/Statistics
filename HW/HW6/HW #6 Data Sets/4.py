from __future__ import division
import numpy as np
import scipy.cluster.hierarchy as hac
import matplotlib.pyplot as plt
import pandas as pd
from scipy.cluster.vq import kmeans, vq

data = pd.read_csv("pharma.csv")
variables = data.ix[:, 2:11].as_matrix()

# hierarchical clustering
print 'Hierarchical clustering'
fig, axes23 = plt.subplots(2, 3)
for method, axes in zip(['single', 'complete'], axes23):
    print method
    z = hac.linkage(variables, method=method)

    # Plotting
    axes[0].plot(range(1, len(z)+1), z[::-1, 2])
    knee = np.diff(z[::-1, 2], 2)
    axes[0].plot(range(2, len(z)), knee)

    num_clust1 = knee.argmax() + 2
    knee[knee.argmax()] = 0
    num_clust2 = knee.argmax() + 2

    axes[0].text(num_clust1, z[::-1, 2][num_clust1-1], 'possible\n<- knee point')

    part1 = hac.fcluster(z, num_clust1, 'maxclust')
    print num_clust1, list(part1)
    part2 = hac.fcluster(z, num_clust2, 'maxclust')
    print num_clust2, list(part2)
    for i in range(len(part2)):
        print data.ix[i, 1], part2[i]

    clr = ['#2200CC' ,'#D9007E' ,'#FF6600' ,'#FFCC00' ,'#ACE600' ,'#0099CC' ,
    '#8900CC' ,'#FF0000' ,'#FF9900' ,'#FFFF00' ,'#00CC01' ,'#0055CC']

    for part, ax in zip([part1, part2], axes[1:]):
        for cluster in set(part):
            ax.scatter(variables[part == cluster, 4], variables[part == cluster, 6],
                       color=clr[cluster])

    m = '\n(method: {})'.format(method)
    plt.setp(axes[0], title='Screeplot{}'.format(m), xlabel='partition',
             ylabel='{}\ncluster distance'.format(m))
    plt.setp(axes[1], title='{} Clusters'.format(num_clust1))
    plt.setp(axes[2], title='{} Clusters'.format(num_clust2))

plt.tight_layout()
plt.show()

# kmeans
print 'kmeans'
for i in range(2,10):
    centroids,_ = kmeans(variables,i)
    idx,_ = vq(variables, centroids)
    print i, [el if el else i for el in idx]
    print