#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import matplotlib.patches as patches
import scipy.interpolate

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble']=[r'\usepackage{amsmath}']

directory = r'plots/NMSSMEFTHiggs/'

# plot Mh(MS)

def plot(Xt, lam, kap):
    Xtstr = str(Xt)
    lamstr = str(lam)
    kapstr = str(kap)
    outfile = directory + r'DMh_MS_TB-5_Xt-' + Xtstr + '_lam-' + lamstr + '_kap-' + kapstr + '.pdf'

    try:
        data = np.genfromtxt(directory + r'scan_NMSSM_TB-5_Xt-' + Xtstr + '_lam-' + lamstr + '_kap-' + kapstr + '.dat')
    except:
        print "Error: could not load numerical data from file"
        exit

    x             = data[:,0]
    yMSSM         = data[:,1]
    dMSSM         = data[:,2]
    yMSSMEFTHiggs = data[:,3]
    dMSSMEFTHiggs = data[:,4]

    plt.rc('text', usetex=True)
    plt.rc('font', family='serif', weight='normal')
    fig = plt.figure(figsize=(4,4))
    plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
    plt.grid(color='0.5', linestyle=':', linewidth=0.2, dashes=(0.5,1.5))

    ax = plt.gca()
    ax.set_axisbelow(True)
    ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
    ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
    ax.get_yaxis().set_tick_params(which='both',direction='in')
    ax.get_xaxis().set_tick_params(which='both',direction='in')

    plt.xscale('log')
    plt.xlabel(r'$M_S\,/\,\mathrm{GeV}$')
    plt.ylabel(r'$M_h\,/\,\mathrm{GeV}$')
    plt.xlim([100,100000])
    # plt.ylim([80,130])

    hMSSM, = plt.plot(x, yMSSM        , 'b--', linewidth=1.2, label=r'fixed 2-loop order')
    hmix,  = plt.plot(x, yMSSMEFTHiggs, 'r-' , linewidth=1.2, label=r'FlexibleEFTHiggs')
    plt.fill_between(x, yMSSM - dMSSM, yMSSM + dMSSM,
                     color='blue', alpha=0.3, interpolate=True, linewidth=0.0)
    plt.fill_between(x, yMSSMEFTHiggs - dMSSMEFTHiggs, yMSSMEFTHiggs + dMSSMEFTHiggs,
                     color='red', alpha=0.3, interpolate=True, linewidth=0.0)

    leg = plt.legend(handles = [hMSSM, hmix],
                     loc='lower right', fontsize=10, fancybox=None, framealpha=None)
    leg.get_frame().set_alpha(1.0)
    leg.get_frame().set_edgecolor('black')

    plt.title(r'$X_t/M_S = ' + Xtstr + r', \tan\beta = 5, \lambda = ' + lamstr + r', \kappa = ' + kapstr + r'$',
              color='k', fontsize=10)

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

    plt.text(ax.get_xlim()[0] + 10, Mhexp + sigma + 0.4, r"ATLAS/CMS $\pm1\sigma$", fontsize=8)

    plt.tight_layout()
    plt.savefig(outfile)
    print "saved plot in ", outfile
    plt.close(fig)

plot(0, 0.1, 0.1)
plot(0, 0.3, 0.3)
plot(-2, 0.1, 0.1)
plot(-2, 0.3, 0.3)
