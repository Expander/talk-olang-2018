#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble']=[r'\usepackage{amsmath}']

directory = r'plots/uncertainties/'

# plot Mh(MS)

outfile = directory + r'Mh_MS_TB-5_Xt-0_FO_EFT.pdf'

try:
    dataMSSMEFTHiggs = np.genfromtxt(directory + r'MSSMEFTHiggs_MS_TB-5_Xt-0..dat')
    dataMSSM         = np.genfromtxt(directory + r'scan_FeynHiggs-2.13.0beta_Mh_MS_TB-5_Xt-0.dat')
    dataSUSYHD       = np.genfromtxt(directory + r'SUSYHD_MS_TB-5_Xt-1..dat')
    dataHSSUSY       = np.genfromtxt(directory + r'HSSUSY_MS_TB-5_Xt-0..dat')
except:
    print "Error: could not load numerical data from file"
    exit

xMSSMEFTHiggs = dataMSSMEFTHiggs[:,0]
xMSSM         = dataMSSM[:,0]
xSUSYHD       = dataHSSUSY[:,0]

yMSSMEFTHiggs = dataMSSMEFTHiggs[:,1]
yMSSM         = dataMSSM[:,1]
ySUSYHD       = dataHSSUSY[:,1]

dMSSMEFTHiggs = dataMSSMEFTHiggs[:,2]
dMSSM         = dataMSSM[:,2]
dSUSYHD       = dataSUSYHD[:,2]

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
plt.ylabel(r'$M_h\,/\,\mathrm{GeV}$')
plt.xlim([100,10000])
plt.ylim([80,125])

hMSSM, = plt.plot(xMSSM        , yMSSM        , 'b--', linewidth=1.2, label=r'2L fixed-order')
hEFT,  = plt.plot(xSUSYHD      , ySUSYHD      , 'g-.', linewidth=1.2, dashes=(5,3,1,3), label=r'2L EFT')
plt.fill_between(xMSSM, yMSSM - dMSSM, yMSSM + dMSSM,
                 color='blue', alpha=0.3, interpolate=True, linewidth=0.0)
plt.fill_between(xSUSYHD, ySUSYHD - dSUSYHD, ySUSYHD + dSUSYHD,
                 color='green', alpha=0.3, interpolate=True, linewidth=0.0)

leg = plt.legend(handles = [hMSSM, hEFT],
                 loc='lower right', fontsize=10, fancybox=None, framealpha=None)
leg.get_frame().set_alpha(1.0)
leg.get_frame().set_edgecolor('black')

plt.title(r'$X_t = 0, \tan\beta = 5$', color='k', fontsize=10)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
