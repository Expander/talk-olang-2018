#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import matplotlib.patches as patches
import scipy.interpolate

def plot(datafile, outfile, title, label_y, range_y, range_x):
    plt.rcParams['text.usetex'] = True
    plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]

    try:
        data = np.genfromtxt(datafile)
    except:
        print "Error: could not load numerical data from file"
        exit

    MS          = data[:,0]
    Mh          = data[:,1]
    DMh         = data[:,2]
    DMhQpole    = data[:,3]
    DMhQmatch   = data[:,4]
    DMhMt       = data[:,5]
    DMhAlphaS   = data[:,6]
    DMhAlphaEm  = data[:,7] * 1000

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

    plt.plot(MS, DMh       , 'r-' , linewidth=1.2)
    plt.plot(MS, DMhQpole  , 'b--', linewidth=1.0)
    plt.plot(MS, DMhQmatch , 'b-.', linewidth=1.0)
    plt.plot(MS, DMhMt     , 'g:' , linewidth=1.0)
    plt.plot(MS, DMhAlphaS , linewidth=1.0, color='orange', dashes=(2,1,2,3))
    plt.plot(MS, DMhAlphaEm, linewidth=1.0, color='darkred', dashes=(1,1,1,1,3,1))

    leg = plt.legend([r'combined',
                      r'$\Delta M_h^{(Q_{\text{pole}})}$',
                      r'$\Delta M_h^{(Q_{\text{match}})}$',
                      r'$\Delta M_h^{(m_t)}$',
                      r'$\Delta M_h^{(\alpha_{\text{s}})}$',
                      r'$\Delta M_h^{(\alpha_{\text{e.m.}})}$ $\times 1000$'],
                     loc='upper left', fontsize=10, fancybox=None, framealpha=None)
    leg.get_frame().set_alpha(1.0)
    leg.get_frame().set_edgecolor('black')
    plt.ylim(range_y)
    plt.xlim(range_x)

    plt.savefig(outfile)
    print "saved plot in ", outfile
    plt.close(fig)

plot(r'SS_TB-20_Xt--sqrt6.dat',
     r'SS_TB-20_Xt--sqrt6_individual.pdf',
     r'$X_t = -\sqrt{6}M_S, \tan\beta = 20$',
     r'$\Delta M_h\,/\,\mathrm{GeV}$', [0,5], [500,10000])
