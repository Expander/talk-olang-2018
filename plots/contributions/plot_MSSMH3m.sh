#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

directory = r'./plots/contributions/'

# plot Mh(Xt)

outfile = directory + r'scan_Mh_MS_TB-5_Xt-0_contributions.pdf'

try:
    dataMSSMas0Lyt1LMh2L   = np.genfromtxt(directory + r'scan_NUHMSSMNoFV_Mh_MS_as0L_yt1L_Mh2L_TB-5_Xt-0.dat')
    dataMSSMas1Lyt1LMh2L   = np.genfromtxt(directory + r'scan_NUHMSSMNoFV_Mh_MS_as1L_yt1L_Mh2L_TB-5_Xt-0.dat')
    dataMSSMas0Lyt2LMh2L   = np.genfromtxt(directory + r'scan_NUHMSSMNoFVH3m_Mh_MS_as0L_yt2L_Mh2L_TB-5_Xt-0.dat')
    dataMSSMas1Lyt2LMh3L   = np.genfromtxt(directory + r'scan_NUHMSSMNoFVH3m_Mh_MS_as1L_yt2L_Mh3L_TB-5_Xt-0.dat')
except:
    print "Error: could not load numerical data from file"
    exit

xMSSMas0Lyt1LMh2L     = dataMSSMas0Lyt1LMh2L[:,0]
xMSSMas1Lyt1LMh2L     = dataMSSMas1Lyt1LMh2L[:,0]
xMSSMas0Lyt2LMh2L     = dataMSSMas0Lyt2LMh2L[:,0]
xMSSMas1Lyt2LMh3L     = dataMSSMas1Lyt2LMh3L[:,0]

yMSSMas0Lyt1LMh2L     = dataMSSMas0Lyt1LMh2L[:,1]
yMSSMas1Lyt1LMh2L     = dataMSSMas1Lyt1LMh2L[:,1]
yMSSMas0Lyt2LMh2L     = dataMSSMas0Lyt2LMh2L[:,1]
yMSSMas1Lyt2LMh3L     = dataMSSMas1Lyt2LMh3L[:,1]

yShiftYt       = yMSSMas0Lyt2LMh2L - yMSSMas0Lyt1LMh2L # shift due to y_{t,b}^2L
yShiftas       = yMSSMas1Lyt1LMh2L - yMSSMas0Lyt1LMh2L # shift due to alpha_s^1L
ySum           = yShiftYt + yShiftas # sum of shifts shift
# ySum           = yMSSMas1Lyt2LMh3L - yMSSMas0Lyt1LMh2L # sum of shifts shift
# yShiftMh3      = ySum - yShiftYt - yShiftas            # shift due to M_h^3L

plt.rc('text', usetex=True)
plt.rc('font', family='serif', weight='normal')
fig = plt.figure(figsize=(5,4))
plt.gcf().subplots_adjust(bottom=0.15, left=0.2) # room for xlabel
ax = plt.gca()
ax.set_axisbelow(True)
ax.xaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
ax.yaxis.set_major_formatter(tck.FormatStrFormatter(r'$%d$'))
plt.rcParams['text.latex.preamble']=[r"\usepackage{amsmath}"]
plt.grid(color='gray', linestyle=':', linewidth=0.2)

plt.xscale('log')
plt.xlabel(r'$M_S\,/\,\mathrm{GeV}$')
plt.ylabel(r'$\left[M_h - M_h^{2L}(y_{t,b}^{1L},\alpha_s^{0L})\right]\,/\,\mathrm{GeV}$')

plt.plot(xMSSMas0Lyt1LMh2L, yShiftYt   , c='g', linewidth=1.2, dashes=(5,3,1,3))
plt.plot(xMSSMas0Lyt1LMh2L, yShiftas   , 'b--', linewidth=1.2)
# plt.plot(xMSSMas0Lyt1LMh2L, yShiftMh3  , 'k:' , linewidth=2)
plt.plot(xMSSMas0Lyt1LMh2L, ySum       , 'r-' , linewidth=1.2)

plt.axhline(y=0, color='k', linestyle='-')

plt.legend([r'shift from $y_{t,b}^{1L} \rightarrow y_{t,b}^{2L}$',
            r'shift from $\alpha_s^{0L} \rightarrow \alpha_s^{1L}$',
            # r'shift from $M_h^{2L} \rightarrow M_h^{3L}$',
            r'sum'],
           loc='upper left', fontsize=10, fancybox=None, framealpha=None)

plt.title(r'$X_t = 0, \tan\beta = 5$')

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
