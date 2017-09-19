#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble']=[r'\usepackage{amsmath}']

directory = r'plots/uncertainties/'

# plot Mh(MS)

outfile = directory + r'DMh_MS_TB-5_Xt-1.pdf'

try:
    dataMSSMEFTHiggs = np.genfromtxt(directory + r'MSSMEFTHiggs_MS_TB-5_Xt-1..dat')
    dataMSSM         = np.genfromtxt(directory + r'NUHMSSMNoFV_MS_TB-5_Xt-1..dat')
    # dataMSSM         = np.genfromtxt(directory + r'scan_FeynHiggs-2.13.0beta_Mh_MS_TB-5_Xt-0.dat')
    dataSUSYHD       = np.genfromtxt(directory + r'SUSYHD_MS_TB-5_Xt-1..dat')
except:
    print "Error: could not load numerical data from file"
    exit

xMSSMEFTHiggs = dataMSSMEFTHiggs[:,0]
xMSSM         = dataMSSM[:,0]
xSUSYHD       = dataSUSYHD[:,0]

yMSSMEFTHiggs = dataMSSMEFTHiggs[:,2]
yMSSM         = dataMSSM[:,2]
ySUSYHD       = dataSUSYHD[:,2]

plt.rc('text', usetex=True)
plt.rc('font', family='serif', weight='normal')
fig = plt.figure(figsize=(4,4))
plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
ax = plt.gca()
ax.set_axisbelow(True)
ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.get_yaxis().set_tick_params(direction='in', which='both', right=True)
ax.get_xaxis().set_tick_params(direction='in', which='both', top=True)
plt.grid(color='0.5', linestyle=':', linewidth=0.2, dashes=(0.5,1.5))

plt.xscale('log')
plt.xlabel(r'$M_S\,/\,\mathrm{GeV}$')
plt.ylabel(r'$\Delta M_h\,/\,\mathrm{GeV}$')

plt.plot(xMSSM        , yMSSM        , 'b--', linewidth=1.2)
plt.plot(xSUSYHD      , ySUSYHD      , 'g-.', linewidth=1.2, dashes=(5,3,1,3))
plt.plot(xMSSMEFTHiggs, yMSSMEFTHiggs, 'r-' , linewidth=1.2)
plt.ylim([0, 6])

leg = plt.legend([r'2L fixed-order',
                  r'2L EFT',
                  r'1L FlexibleEFTHiggs'],
                 loc='upper right', fontsize=10, fancybox=None, framealpha=None)
leg.get_frame().set_alpha(1.0)
leg.get_frame().set_edgecolor('black')

plt.title(r'$X_t = M_S, \tan\beta = 5$', color='k', fontsize=10)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
