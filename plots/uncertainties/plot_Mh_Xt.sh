#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as tck
import scipy.interpolate

plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble']=[r'\usepackage{amsmath}']

directory = r'plots/uncertainties/'

# plot Mh(MS)

outfile = directory + r'Mh_Xt_TB-5_MS-5000.pdf'

try:
    dataMSSMEFTHiggs = np.genfromtxt(directory + r'MSSMEFTHiggs_Xt_TB-5_MS-5000..dat')
    dataMSSM         = np.genfromtxt(directory + r'NUHMSSMNoFVHimalaya_Xt_TB-5_MS-5000..dat')
    dataHSSUSY       = np.genfromtxt(directory + r'HSSUSY_Xt_TB-5_MS-5000..dat')
except:
    print "Error: could not load numerical data from file"
    exit

xMSSMEFTHiggs = dataMSSMEFTHiggs[:,0]
xMSSM         = dataMSSM[:,0]
xHSSUSY       = dataHSSUSY[:,0]

yMSSMEFTHiggs = dataMSSMEFTHiggs[:,1]
yMSSM         = dataMSSM[:,1]
yHSSUSY       = dataHSSUSY[:,1]

dMSSMEFTHiggs = dataMSSMEFTHiggs[:,2]
dMSSM         = dataMSSM[:,2]
dHSSUSY       = dataHSSUSY[:,2]

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

plt.xlabel(r'$X_t/M_S$')
plt.ylabel(r'$M_h\,/\,\mathrm{GeV}$')
# plt.xlim([300,10000])
# plt.ylim([108,126])

hMSSM, = plt.plot(xMSSM        , yMSSM        , 'b--', linewidth=1.2, label=r'3L \texttt{FS+H}')
hEFT,  = plt.plot(xHSSUSY      , yHSSUSY      , 'g-.', linewidth=1.2, dashes=(5,3,1,3), label=r'2L \texttt{HSSUSY}')
hmix,  = plt.plot(xMSSMEFTHiggs, yMSSMEFTHiggs, 'r-' , linewidth=1.2, label=r'1L FlexibleEFTHiggs')
# plt.fill_between(xMSSM, yMSSM - dMSSM, yMSSM + dMSSM,
#                  color='blue', alpha=0.3, interpolate=True, linewidth=0.0)
# plt.fill_between(xHSSUSY, yHSSUSY - dHSSUSY, yHSSUSY + dHSSUSY,
#                  color='green', alpha=0.3, interpolate=True, linewidth=0.0)
# plt.fill_between(xMSSMEFTHiggs, yMSSMEFTHiggs - dMSSMEFTHiggs, yMSSMEFTHiggs + dMSSMEFTHiggs,
#                  color='red', alpha=0.3, interpolate=True, linewidth=0.0)

leg = plt.legend(handles = [hMSSM, hEFT, hmix],
                 loc='lower right', fontsize=10, fancybox=None, framealpha=None)
leg.get_frame().set_alpha(1.0)
leg.get_frame().set_edgecolor('black')

plt.title(r'$M_S = 5\,\text{TeV}, \tan\beta = 5$', color='k', fontsize=10)

plt.savefig(outfile)
print "saved plot in ", outfile
plt.close(fig)
