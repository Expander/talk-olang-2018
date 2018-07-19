#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
plt.rcParams['text.usetex'] = True

directory = r'./'

# plot Mh(MS)

outfile = directory + r'scan_Mh_MS_TB-10_Xt--sqrt6_diff.pdf'

try:
    dataHSSUSY1L     = np.genfromtxt(directory + r'scan_HSSUSY_1L_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataHSSUSY2L     = np.genfromtxt(directory + r'scan_HSSUSY_2L_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataHSSUSY3L     = np.genfromtxt(directory + r'scan_HSSUSY_3L_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataHSSUSY3LH3m  = np.genfromtxt(directory + r'scan_HSSUSY_3L_H3m_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataMSSMEFTHiggs = np.genfromtxt(directory + r'scan_MSSMEFTHiggs_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataMSSMMuBMu    = np.genfromtxt(directory + r'scan_NUHMSSMNoFV_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataMSSMH3m      = np.genfromtxt(directory + r'scan_NUHMSSMNoFVHimalaya_Mh_MS_TB-10_Xt--sqrt6.dat')
except:
    print "Error: could not load numerical data from file"
    exit

xHSSUSY1L     = dataHSSUSY1L[:,0]
xHSSUSY2L     = dataHSSUSY2L[:,0]
xHSSUSY3L     = dataHSSUSY3L[:,0]
xHSSUSY3LH3m  = dataHSSUSY3LH3m[:,0]
xMSSMEFTHiggs = dataMSSMEFTHiggs[:,0]
xMSSMMuBMu    = dataMSSMMuBMu[:,0]
xMSSMH3m      = dataMSSMH3m[:,0]

yHSSUSY1L     = dataHSSUSY1L[:,1]
yHSSUSY2L     = dataHSSUSY2L[:,1]
yHSSUSY3L     = dataHSSUSY3L[:,1]
yHSSUSY3LH3m  = dataHSSUSY3LH3m[:,1]
yMSSMEFTHiggs = dataMSSMEFTHiggs[:,1]
yMSSMMuBMu    = dataMSSMMuBMu[:,1]
yMSSMH3m      = dataMSSMH3m[:,1]

yHSSUSY3L_minus_d = dataHSSUSY3L[:,2]
yHSSUSY3L_plus_d  = dataHSSUSY3L[:,3]
yHSSUSY3L_minus_EFT_d = dataHSSUSY3L[:,4]
yHSSUSY3L_plus_EFT_d  = dataHSSUSY3L[:,5]

plt.rc('text', usetex=True)
plt.rc('font', family='serif', weight='normal')
fig = plt.figure(figsize=(4,4))
plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
ax = plt.gca()
ax.set_axisbelow(True)
ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%g$'))
ax.get_yaxis().set_tick_params(which='both',direction='in')
ax.get_xaxis().set_tick_params(which='both',direction='in')
plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]
plt.grid(color='0.5', linestyle=':', linewidth=0.2, dashes=(0.5,1.5))

plt.xscale('log')
plt.xlabel(r'$M_S\,/\,\text{GeV}$')
plt.ylabel(r'$[M_h - M_h($\texttt{HSSUSY}+\texttt{Himalaya} 3L$)]\,/\,\text{GeV}$')

h2 = plt.plot(xHSSUSY2L    , (yHSSUSY2L - yHSSUSY3L), 'k--', linewidth=1.2)

plt.fill_between(xHSSUSY3L,
                 (yHSSUSY3L - yHSSUSY3L_plus_d), 
                 (yHSSUSY3L - yHSSUSY3L_minus_d),
                 facecolor='gray', alpha=0.4, linewidth=0.0)
pLam = plt.Rectangle((0, 0), 0, 0, facecolor='gray', alpha=0.4, linewidth=0.0)
hpLam = ax.add_patch(pLam)

plt.axhline(y=0, color='k', linestyle='-', linewidth=1.2)

plt.title(r'$\tan\beta = 10, X_t = -\sqrt{6}M_S$')

leg = plt.legend([h2[0], hpLam],
                 [r'\texttt{FS/HSSUSY} 2L',
                  r'$\pm\delta(\Delta\bar{\lambda})$'],
                 loc='upper right', fontsize=10, fancybox=None, framealpha=None)
leg.get_frame().set_alpha(1.0)
leg.get_frame().set_edgecolor('black')
plt.ylim([-0.5,0.5])
plt.xlim([10**3,10**4])

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
