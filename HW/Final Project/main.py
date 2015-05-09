from __future__ import division
__author__ = 'sivanov'
import networkx as nx
import matplotlib.pyplot as plt
import powerlaw
import numpy as np

def read_file(filename):
    G = nx.Graph()
    with open(filename) as f:
        for line in f:
            d = line.split()
            G.add_edge(d[0],d[1])
    print 'n: %s m: %s' %(len(G), len(G.edges()))
    return G

def CC_analysis(G, subplot=1, add_title=''):
    CCs = list(nx.connected_components(G))
    sizes = sorted([len(cc) for cc in CCs], reverse=True)
    print 'Total number of CCs is', len(CCs)
    print 'The size of largest connected component is', sizes[0]
    print 'The size of second largest connected component is', sizes[1]
    print len(G), np.log(len(G))
    # plt.subplot(3,1,subplot)
    plt.hist(sizes, bins=range(1,21))
    plt.title(add_title + "Sizes of connected components.")
    plt.xlabel("Size")
    plt.ylabel("Frequency")
    # plt.show()
    return sizes

def powerlaw_fit(G,subplot=1, add_title=''):
    degrees = G.degree().values()
    fit = powerlaw.Fit(degrees, xmin=None)
    print fit.power_law.alpha
    print fit.power_law.sigma
    print fit.power_law.xmin
    plt.subplot(2,1,subplot)
    fit.plot_pdf(linewidth=3)
    fit.power_law.plot_pdf(linestyle='--', linewidth=2)
    fit.truncated_power_law.plot_pdf(linestyle='--', linewidth=2)
    L, p = fit.distribution_compare('power_law', 'lognormal', normalized_ratio=True)
    plt.title(add_title + r'$L=%.2f$ $p=%e$' %(L, p))# + r'$x_{min}=%.2f$' %(fit.power_law.xmin) + r'\sigma_{\alpha}=%.2f$' %(fit.power_law.sigma))
    plt.xlabel('Degree k')
    plt.ylabel('P(x = k)')
    plt.legend(['Empirical', 'Power Law', 'Truncated Power Law'], loc=3)
    # plt.show()
    print fit.distribution_compare('power_law', 'exponential', normalized_ratio=True)

def plot_degree(G):

    degree_sequence=sorted(nx.degree(G).values(),reverse=True) # degree sequence

    plt.loglog(degree_sequence,'b-',marker='o')
    plt.title("Degree rank plot")
    plt.ylabel("degree")
    plt.xlabel("rank")
    plt.show()

def plot_freq(G, add_title):
    n = len(G)
    degrees = G.degree().values()
    from collections import Counter
    counts = Counter(degrees)
    freq = {}
    for c in counts:
        freq[c] = counts[c]/n
    plt.subplot(3,1,3)
    plt.plot(*zip(*freq.items()), linewidth=2)
    # plt.xlim([0,100])
    plt.title(add_title + 'Degree Distribution')
    plt.xlabel('Degree k')
    plt.ylabel('P(x = k)')
    # plt.xscale('log')
    # plt.show()

if __name__ == "__main__":
    G1 = read_file("Email-Enron.txt")
    G2 = read_file("CA-HepPh.txt")
    # G3 = read_file("roadNet-TX.txt")
    # G4 = read_file("flixster.txt")
    # powerlaw_fit(G4, 1, '')
    powerlaw_fit(G1,1, add_title="Communication Network. ")
    powerlaw_fit(G2,2, add_title="Collaboration Network. ")
    # CC_analysis(G1, add_title="Communication Network. ")
    plt.tight_layout()
    plt.show()

    # CC_analysis(G3, 0,'')
    # powerlaw_fit(G1,1,'Email Network. ')
    # powerlaw_fit(G2,2,'Collaboration Network. ')
    # powerlaw_fit(G3)

    # plot_freq(G3,'Roads Network. ')

    # CC_analysis(G1, 1, 'Email Network. ')
    # CC_analysis(G2, 2, 'Collaboration Network. ')
    # CC_analysis(G3, 3, 'Roads Network. ')
    # plt.tight_layout()
    # plt.show()

    console = []