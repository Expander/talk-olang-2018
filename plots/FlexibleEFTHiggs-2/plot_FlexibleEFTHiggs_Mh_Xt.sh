#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

directory = r'plots/FlexibleEFTHiggs-2/'

# plot Mh(Xt)

outfile = directory + r'scan_Mh_Xt_TB-5_MS-2000.pdf'

try:
    dataHSSUSY     = np.genfromtxt(directory + r'scan_HSSUSY_Mh_Xt_TB-5_MS-2000.dat')
    dataHSSUSY1    = np.genfromtxt(directory + r'scan_HSSUSY-1L_Mh_Xt_TB-5_MS-2000.dat')
    dataMSSMtower  = np.genfromtxt(directory + r'scan_MSSMtower-1.0_Mh_Xt_TB-5_MS-2000.dat')
    dataMSSMtower2 = np.genfromtxt(directory + r'scan_MSSMtower-2.0_Mh_Xt_TB-5_MS-2000.dat')
    dataMSSMMuBMu  = np.genfromtxt(directory + r'scan_FeynHiggs-2.13.0beta_Mh_Xt_TB-5_MS-2000.dat')
except:
    print "Error: could not load numerical data from file"
    exit

xHSSUSY     = dataHSSUSY[:,0]
xHSSUSY1    = dataHSSUSY1[:,0]
xMSSMtower  = dataMSSMtower[:,0]
xMSSMtower2 = dataMSSMtower2[:,0]
xMSSMMuBMu  = dataMSSMMuBMu[:,0]

yHSSUSY     = dataHSSUSY[:,1]
yHSSUSY1    = dataHSSUSY1[:,1]
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
plt.xlim([-3,3])
plt.ylim([100,126])

plt.xlabel(r'$X_t / M_S$')
plt.ylabel(r'$M_h\;/\;\mathrm{GeV}$')

hmix, = plt.plot(xMSSMtower2, yMSSMtower2, 'r-' , linewidth=1.2, label=r'1L FlexibleEFTHiggs')
#plt.plot(xMSSMtower , yMSSMtower , 'r:' , linewidth=2)
hEFT2, = plt.plot(xHSSUSY    , yHSSUSY    , 'g'  , linewidth=1.2, dashes=(5,3,1,3), label=r'2L EFT')
hEFT1, = plt.plot(xHSSUSY1   , yHSSUSY1   , 'k:' , linewidth=2, label=r'1L EFT')
hMSSM, = plt.plot(xMSSMMuBMu , yMSSMMuBMu , 'b--', linewidth=1.2, label=r'2L fixed-order')

plt.legend(handles = [hMSSM, hEFT2, hEFT1, hmix],
           loc='lower right', fontsize=10)

plt.title(r'$M_S = 2\;\mathrm{TeV}, \tan\beta = 5$', color='k', fontsize=10)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
