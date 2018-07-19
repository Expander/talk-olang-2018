#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate
from matplotlib.patches import Rectangle

def plot_uncertainty(outfile):
    try:
        dataMSSM2L   = np.genfromtxt(r'scan_NUHMSSMNoFV_2L_Mh_MS_TB-20_Xt--sqrt6.dat')
        dataMSSM3L   = np.genfromtxt(r'scan_NUHMSSMNoFV_3L_Mh_MS_TB-20_Xt--sqrt6.dat')
    except:
        print "Error: could not load numerical data from file"
        exit

    xMSSM2L = dataMSSM2L[:,0]
    xMSSM3L = dataMSSM3L[:,0]
    yMSSM2L = dataMSSM2L[:,1]
    yMSSM3L = dataMSSM3L[:,1]

    yMSSM2LQpoleMin = dataMSSM2L[:,2]
    yMSSM3LQpoleMin = dataMSSM3L[:,2]
    yMSSM2LQpoleMax = dataMSSM2L[:,3]
    yMSSM3LQpoleMax = dataMSSM3L[:,3]

    plt.rc('text', usetex=True)
    plt.rc('font', family='serif', weight='normal')
    fig = plt.figure(figsize=(4,4))
    plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
    plt.gca().set_axisbelow(True)
    ax = plt.gca()
    ax.set_axisbelow(True)
    ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
    ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%2.1f$'))
    ax.get_yaxis().set_tick_params(which='both',direction='in')
    ax.get_xaxis().set_tick_params(which='both',direction='in')
    plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]
    plt.grid(color='0.5', linestyle=':', linewidth=0.2, dashes=(0.5,1.5))

    plt.title(r'$X_t = -\sqrt{6}M_S$, $\tan\beta = 20$')
    plt.xscale('log')
    plt.xlabel(r'$M_S\;/\;\text{GeV}$')
    plt.ylabel(r'$\Delta M_h^{(Q_{\text{pole}})}\;/\;\text{GeV}$')

    plt.fill_between(xMSSM3L, yMSSM3LQpoleMin - yMSSM3L, yMSSM3LQpoleMax - yMSSM3L,
                     facecolor='red', alpha=0.4, interpolate=True, linewidth=0.0)
    plt.fill_between(xMSSM2L, yMSSM2LQpoleMin - yMSSM2L, yMSSM2LQpoleMax - yMSSM2L,
                     facecolor='blue', alpha=0.3, interpolate=True, linewidth=0.0)

    leg = plt.legend([r'\texttt{FlexibleSUSY}+\texttt{Himalaya} 3L',
                      r'\texttt{FlexibleSUSY} 2L'],
                     loc='lower left', fontsize=10, fancybox=None, framealpha=None)
    leg.get_frame().set_alpha(1.0)
    leg.get_frame().set_edgecolor('black')
    plt.ylim([-2,2])
    plt.xlim([500,10000])

    plt.axhline(y=0, color='k', linestyle='-')

    plt.savefig(outfile)
    print "saved plot in ", outfile
    plt.close(fig)

plot_uncertainty(r'scan_Mh_MS_TB-20_Xt--sqrt6_uncertainty_Qpole.pdf')
