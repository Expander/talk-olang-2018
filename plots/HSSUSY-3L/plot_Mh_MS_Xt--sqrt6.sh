#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import matplotlib.patches as patches
plt.rcParams['text.usetex'] = True

directory = r'./'

# plot Mh(MS)

outfile = directory + r'scan_Mh_MS_TB-10_Xt--sqrt6.pdf'

try:
    dataHSSUSY1L     = np.genfromtxt(directory + r'scan_HSSUSY_1L_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataHSSUSY2L     = np.genfromtxt(directory + r'scan_HSSUSY_2L_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataHSSUSY3L     = np.genfromtxt(directory + r'scan_HSSUSY_3L_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataMSSMEFTHiggs = np.genfromtxt(directory + r'scan_MSSMEFTHiggs_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataMSSMMuBMu    = np.genfromtxt(directory + r'scan_NUHMSSMNoFV_Mh_MS_TB-10_Xt--sqrt6.dat')
    dataMSSMH3m      = np.genfromtxt(directory + r'scan_NUHMSSMNoFVHimalaya_Mh_MS_TB-10_Xt--sqrt6.dat')
except:
    print "Error: could not load numerical data from file"
    exit

xHSSUSY2L     = dataHSSUSY2L[:,0]
xHSSUSY3L     = dataHSSUSY3L[:,0]
xMSSMEFTHiggs = dataMSSMEFTHiggs[:,0]
xMSSMMuBMu    = dataMSSMMuBMu[:,0]
xMSSMH3m      = dataMSSMH3m[:,0]

yHSSUSY2L     = dataHSSUSY2L[:,1]
yHSSUSY3L     = dataHSSUSY3L[:,1]
yMSSMEFTHiggs = dataMSSMEFTHiggs[:,1]
yMSSMMuBMu    = dataMSSMMuBMu[:,1]
yMSSMH3m      = dataMSSMH3m[:,1]

plt.rc('text', usetex=True)
plt.rc('font', family='serif', weight='normal')
fig = plt.figure(figsize=(4,4))
plt.gcf().subplots_adjust(bottom=0.15, left=0.15) # room for xlabel
ax = plt.gca()
ax.set_axisbelow(True)
ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.get_yaxis().set_tick_params(which='both',direction='in')
ax.get_xaxis().set_tick_params(which='both',direction='in')
plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]
plt.grid(color='0.5', linestyle=':', linewidth=0.2, dashes=(0.5,1.5))

plt.xscale('log')
plt.xlabel(r'$M_S\,/\,\text{GeV}$')
plt.ylabel(r'$M_h\,/\,\text{GeV}$')

plt.plot(xMSSMMuBMu   , yMSSMMuBMu   , 'b--', linewidth=1.2)
plt.plot(xMSSMH3m     , yMSSMH3m     , 'r-' , linewidth=1.2)
# plt.plot(xMSSMEFTHiggs, yMSSMEFTHiggs, 'g-.', linewidth=1.2)
plt.plot(xHSSUSY2L    , yHSSUSY2L    , 'k--', linewidth=1.2)
plt.plot(xHSSUSY3L    , yHSSUSY3L    , 'k-' , linewidth=1.2)

plt.title(r'$\tan\beta = 10, X_t = -\sqrt{6}M_S$')

leg = plt.legend([r'\texttt{FS} 2L',
                  r'\texttt{FS}+\texttt{Himalaya} 3L',
                  r'\texttt{FS/HSSUSY} 2L',
                  r'\texttt{FS/HSSUSY}+\texttt{Himalaya} 3L'],
           loc='lower right', fontsize=10, fancybox=None, framealpha=None)
leg.get_frame().set_alpha(1.0)
leg.get_frame().set_edgecolor('black')
plt.ylim([118,131])
plt.xlim([10**3,10**4])

# draw observed value
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

plt.text(ax.get_xlim()[0] + 100, Mhexp + sigma + 0.5, r"ATLAS/CMS $\pm1\sigma$", fontsize=8)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
