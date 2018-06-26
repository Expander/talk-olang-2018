#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import matplotlib.patches as patches
import scipy.interpolate

def plot(datafile, outfile, title, label_y, range_y, range_x, curves=[1,1]):
    plt.rcParams['text.usetex'] = True
    plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]

    try:
        dataSS = np.genfromtxt(datafile[0])
        dataFS = np.genfromtxt(datafile[1])
    except:
        print "Error: could not load numerical data from file"
        exit

    MSSS   = dataSS[:,0]
    MhSS   = dataSS[:,1]
    DMhSS  = dataSS[:,2]
    MSFS   = dataFS[:,0]
    MhFS   = dataFS[:,1]
    DMhFS  = dataFS[:,2]
    MhEFT  = dataFS[:,3]
    DMhEFT = dataFS[:,4]

    plt.rc('text', usetex=True)
    plt.rc('font', family='serif', weight='normal')
    fig = plt.figure(figsize=(4,4))
    plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
    ax = plt.gca()
    ax.set_axisbelow(True)
    ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%g$'))
    ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%g$'))
    ax.get_yaxis().set_tick_params(which='both',direction='in')
    ax.get_xaxis().set_tick_params(which='both',direction='in')
    plt.grid(color='0.5', linestyle=':', linewidth=0.2, dashes=(0.5,1.5))

    plt.xscale('log')
    plt.xlabel(r'$M_S\,/\,\mathrm{GeV}$')
    plt.ylabel(label_y)
    plt.title(title)

    if curves[0]: plt.plot(MSSS, MhSS , 'r-' , linewidth=1.2)
    if curves[1]: plt.plot(MSFS, MhEFT, 'k:' , linewidth=1.2)
    # plt.plot(MSFS, MhFS , 'b--', linewidth=1.2)

    if curves[0]:
        plt.fill_between(MSSS, MhSS - DMhSS, MhSS + DMhSS,
                         facecolor='red', alpha=0.3, interpolate=True, linewidth=0.0)

    if curves[1]:
        plt.fill_between(MSFS, MhEFT - DMhEFT, MhEFT + DMhEFT,
                         facecolor='black', alpha=0.3, interpolate=True, linewidth=0.0)

    labels = []
    if curves[0]: labels.append(r'\texttt{SOFTSUSY+Himalaya}')
    if curves[1]: labels.append(r'\texttt{HSSUSY+Himalaya}')

    leg = plt.legend(labels,
                     loc='lower right', fontsize=10, fancybox=None, framealpha=None)
    leg.get_frame().set_alpha(1.0)
    leg.get_frame().set_edgecolor('black')
    plt.ylim(range_y)
    plt.xlim(range_x)

    Mhexp = 125.09
    sigma = 0.32
    
    ax.add_patch(
        patches.Rectangle(
            (ax.get_xlim()[0], Mhexp - sigma)  , # (x,y)
            ax.get_xlim()[1] - ax.get_xlim()[0], # width
            2*sigma                            , # height
            color='orange', alpha=0.5, zorder=-1
        )
    )

    plt.text(ax.get_xlim()[0] + 50, Mhexp + sigma + 0.4, r"ATLAS/CMS $\pm1\sigma$", fontsize=8)

    plt.savefig(outfile)
    print "saved plot in ", outfile
    plt.close(fig)

plot([r'SS_TB-20_Xt--sqrt6.dat', r'FS_TB-20_Xt--sqrt6.dat'],
     r'SS_TB-20_Xt--sqrt6.pdf',
     r'$X_t = -\sqrt{6}M_S, \tan\beta = 20$',
     r'$M_h\,/\,\mathrm{GeV}$', [112,135], [500,10000], [1,0])

plot([r'SS_TB-20_Xt--sqrt6.dat', r'FS_TB-20_Xt--sqrt6.dat'],
     r'Mh_MS_TB-20_Xt--sqrt6.pdf',
     r'$X_t = -\sqrt{6}M_S, \tan\beta = 20$',
     r'$M_h\,/\,\mathrm{GeV}$', [112,135], [500,10000], [1,1])
