#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

directory = r'plots/FlexibleEFTHiggs/'

# plot Mh(MS)

outfile = directory + r'scan_Mh_MS_TB-5_Xt-0.pdf'

try:
    dataHSSUSY     = np.genfromtxt(directory + r'scan_HSSUSY_Mh_MS_TB-5_Xt-0.dat')
    dataMSSMtower  = np.genfromtxt(directory + r'scan_MSSMtower-1.0_Mh_MS_TB-5_Xt-0.dat')
    dataMSSMtower2 = np.genfromtxt(directory + r'scan_MSSMtower-2.0_Mh_MS_TB-5_Xt-0.dat')
    dataMSSMMuBMu  = np.genfromtxt(directory + r'scan_MSSMMuBMu_Mh_MS_TB-5_Xt-0.dat')
except:
    print "Error: could not load numerical data from file"
    exit

xHSSUSY     = dataHSSUSY[:,0]
xMSSMtower  = dataMSSMtower[:,0]
xMSSMtower2 = dataMSSMtower2[:,0]
xMSSMMuBMu  = dataMSSMMuBMu[:,0]

yHSSUSY     = dataHSSUSY[:,1]
yMSSMtower  = dataMSSMtower[:,1]
yMSSMtower2 = dataMSSMtower2[:,1]
yMSSMMuBMu  = dataMSSMMuBMu[:,1]

fig = plt.figure(figsize=(4,4))
plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
ax = plt.gca()
ax.set_axisbelow(True)
ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
plt.rc('text', usetex=True)
plt.rc('font', family='serif', weight='normal')
plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]
plt.grid(color='gray', linestyle=':', linewidth=0.2)

plt.xscale('log')
plt.xlabel(r'$M_S\;/\;\mathrm{GeV}$')
plt.ylabel(r'$M_h\;/\;\mathrm{GeV}$')

plt.plot(xMSSMtower2, yMSSMtower2, 'r-' , linewidth=1.2)
plt.plot(xMSSMtower , yMSSMtower , 'r:' , linewidth=2)
plt.plot(xHSSUSY    , yHSSUSY    , 'b--', linewidth=1.2)
plt.plot(xMSSMMuBMu , yMSSMMuBMu , c='g', linewidth=1.2, dashes=(5,3,1,3))

plt.legend(['$\mathrm{FlexibleEFTHiggs/MSSM\;2.0}$',
            '$\mathrm{FlexibleEFTHiggs/MSSM\;1.0}$',
            '$\mathrm{FlexibleSUSY/HSSUSY\;2L}$',
            '$\mathrm{FlexibleSUSY/MSSM\;2L}$'],
           loc='lower right', fontsize=10)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
