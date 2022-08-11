import pandas as pd

cases = ["courant-0.2", "courant-0.4","courant-0.8"]
dataType = "mpiTimes.csv"
dataframes = {}
for case in cases:
    directoryPath = "../{}/csvData/".format(case)
    dataframes[case] = pd.read_csv(directoryPath+dataType, index_col=1)


    # # add post processed data:
    # #--------------------------
    # # compute the walltime = endtime -starttime
    # dataframes[case] = dataframes[case].assign(wallTime = dataframes[case]["endWallTime"].values - dataframes[case]["startWallTime"].values )
    # # compute the cost of everything other than the pressure
    # dataframes[case] = dataframes[case].assign(aveOtherPerTimeStep = dataframes[case]["AveTimePerTimeStep"].values - dataframes[case]["aveTotalSolve+setup"].values)
    # dataframes[case] = dataframes[case].assign(totalOtherPerTimeStep = dataframes[case]["wallTime"].values - dataframes[case]["totalSolve+SetupTime"].values)
    # # compute gamma the ratio of other to pressure solve
    # dataframes[case] = dataframes[case].assign(gamma = dataframes[case]["totalOtherPerTimeStep"].values / dataframes[case]["totalSolve+SetupTime"].values)
    # # print(dataframes[case])

eta = {}

for case in cases:
    otherIntegName =  [name for name in list(set(list(dataframes[case].index))) if name !="RK311"][0]
    
    RK311Data = dataframes[case].loc[["RK311"],["MPIprocs","totalAllMPIWait"]]
    otherIntegData = dataframes[case].loc[[otherIntegName],["MPIprocs","totalAllMPIWait"]]
   
    eta[case] =  {}
    eta[case]["MPIprocs"] = otherIntegData.loc[:,["MPIprocs"]].values
    eta[case]["eta"] = (1 - otherIntegData.loc[:,["totalAllMPIWait"]].values/RK311Data.loc[:,["totalAllMPIWait"]].values)*100
    eta[case]["label"] = "{} {}".format(otherIntegName,case)


# plotting the results

import matplotlib.pyplot as plt
import matplotlib
from matplotlib.ticker import StrMethodFormatter, NullFormatter
import math

font = {'family': 'serif',
        'weight': 'normal',
        'size': 12}

matplotlib.rc('font', **font)
matplotlib.rc('lines', lw=1)
matplotlib.rc('text', usetex=False)
plt.rcParams['mathtext.fontset'] = 'stix'

f, ax = plt.subplots(nrows=1, ncols=1, sharex=False, sharey=False)
f.set_size_inches([4.25, 3.75])

ax.grid(which='minor', alpha=0.19)
colors = ['#2E7990', '#A43F45', '#915F56', '#C49B4C','#aaa367', '#927b97']
markers = ['o', 's', 'D', 'v','*','^','+']
markers_sizes=[4,4,4,4,4,4,4]

for case, c, m, msize in zip(cases, colors, markers, markers_sizes):
    cores = eta[case]["MPIprocs"].ravel()
    etavals   = eta[case]["eta"].ravel()
    lbl   = eta[case]["label"]
    ax.semilogx(cores, etavals, color=c, linewidth=1.5, marker=m, markersize=msize, label=lbl)


# set xticks
coreCount = eta[case]["MPIprocs"].ravel()
ax.set_xticks(coreCount)   
ax.set_xticklabels(coreCount)
ax.xaxis.set_minor_formatter(NullFormatter())

# set the legends
lines,labels = ax.get_legend_handles_labels()
# leg_1 = ax.legend(lines[:2],labels[:2],ncol=1,loc='lower right',bbox_to_anchor=(0,0,0.75,1),fontsize=10,frameon=False, columnspacing=1.0)
leg_2 = ax.legend(lines[:],labels[:],ncol=1,loc='upper right',bbox_to_anchor=(0,0,1,1),fontsize=10,frameon=False, columnspacing=1.0)
# leg_3 = ax.legend(lines[6:],labels[6:],ncol=1,loc='lower right',bbox_to_anchor=(0,0,1,1),fontsize=7,frameon=False, columnspacing=1.0)
# ax.add_artist(leg_1)
ax.add_artist(leg_2)
# ax.add_artist(leg_3)

ax.set_ylabel(r'% $\eta$ total MPI Wait'  , fontsize=12)
ax.set_xlabel('# Cores', fontsize=12)
# ax.set_title('RK2-Heun ', fontsize=10)
# ax.set_ylim([-10,30])
# ax.set_xlim([8e-5,3e-3])

plt.tight_layout()
plt.savefig('./figures/fixed-courant-mpiWait-eta.pdf',transparent=True)
plt.show()