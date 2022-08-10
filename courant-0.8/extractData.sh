#!/bin/bash

here=$PWD
cases="$(find ${here} -name "outputs")"

solverDataPaths="solverData"
scalingDataPaths="scalingData"
# taskGraphDataPaths="taskGraphData"
aveComponentTimesPaths="aveComponentTimes"

for case in $cases;
do 
    echo "working on ${case}"
    cd $case
    # run the extraction scripts
    ./extractSolverScalingData *.out
    ./extractScalingData *.out

    solverDataPaths+=("${case}/scalingData")
    scalingDataPaths+=("${case}/solverScalingData")
    # taskGraphDataPaths+=("${case}/TaskGraphData")
    aveComponentTimesPaths+=("${case}/aveComponentTimes")
done
cd $here

echo "${solverDataPaths[*]}" > $here/dataPaths 
echo "${scalingDataPaths[*]}">> $here/dataPaths 
# echo "${taskGraphDataPaths[*]}">> $here/dataPaths
echo "${aveComponentTimesPaths[*]}">> $here/dataPaths

python $here/dataFrameGen.py