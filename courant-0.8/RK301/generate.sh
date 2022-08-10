#!/bin/bash

#-------------------------------------------------------------------

function modify_ups() {
  ups=$1
  stage_1=$2
  stage_2=$3
  fixed_courant=$4
  output_time=$5
  max_time=$6
  resolution=$7
  patches=$8
  timesteps=$9
  uda="Jet_3D_RK3SSP_stage_1_${stage_1}_stage_2_${stage_2}.uda"
  perl -pi -w -e "s/<<stage_1>>/$stage_1/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<stage_2>>/$stage_2/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<fixed_courant>>/$fixed_courant/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<output_time>>/$output_time/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<max_time>>/$max_time/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<resolution>>/$resolution/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<patches>>/$patches/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<timesteps>>/$timesteps/" $INPUT_DIR/$ups
  perl -pi -w -e "s/<<uda>>/$uda/" $INPUT_DIR/$ups
}
#-------------------------------------------------------------------
PROJECT="Jet-LCS"
SUS="sus"
OUTPUT_DIR="outputs"
INPUT_DIR="inputs"

# CORES="16 32 64 128 256 512 1024 2048 4096"
CORES="16 32 64 128 256 512 1024"

# MEMORY=":mem=110GB"      # use 128GB nodes

JOB="small"
THREADS="1"

#__________________________________
# common to all input files
max_time="0.1" # 10 seconds
fixed_courant="0.8"
output_time="0.005" # results 20 frame per second
timesteps="100"

NAME="RK301"
stage_1="true" # equivalent to !d1
stage_2="false" # equivalent to !d2

#__________________________________
# 16 cores
ups="16.ups"
patches="[4,2,2]"
resolution="[128,64,64]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 32 cores
ups="32.ups"
patches="[4,4,2]"
resolution="[128,128,64]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 64 cores
ups="64.ups"
patches="[4,4,4]"
resolution="[128,128,128]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 128 cores
ups="128.ups"
patches="[8,4,4]"
resolution="[256,128,128]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps


#__________________________________
# 256 cores
ups="256.ups"
patches="[8,8,4]"
resolution="[256,256,128]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 512 cores
ups="512.ups"
patches="[8,8,8]"
resolution="[256,256,256]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 1024 cores
ups="1024.ups"
patches="[16,8,8]"
resolution="[512,256,256]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 2048 cores
ups="2048.ups"
patches="[16,16,8]"
resolution="[512,512,256]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps

#__________________________________
# 4096 cores
ups="4096.ups"
patches="[16,16,16]"
resolution="[512,512,512]"
cp ../3D-jet.ups $INPUT_DIR/$ups
modify_ups $ups $stage_1 $stage_2 $fixed_courant $output_time $max_time $resolution $patches $timesteps


for cores in $CORES; do
    
    size=`expr $cores \* 1` # if using nodes instead of CORES #36 is the number of cores per node` 
    ups=$cores.ups
    
    # if [ $cores -lt 128 ]; then
    #   TIME=00:30:00
    # elif [ $cores -lt 256 ]; then
    #   TIME=00:20:00
    # elif [ $cores -lt 512 ]; then
    #   TIME=00:15:00
    # else
    #   TIME=00:30:00
    # fi

    TIME=00:30:00

    if [ $THREADS -eq 1 ]; then
      procs=$size
      threads=1
    else
      procs=$cores
      threads=$THREADS
    fi 

    export JOB
    export NAME
    export ups
    export size
    export procs
    export threads
    export nodes
    export SUS
    export OUTPUT_DIR
    export INPUT_DIR
    export TIME
    
    # echo "$JOB.$size ../runsus.sh"
    # ../runsus.sh" # uncomment if you want to test locally
    sbatch -t $TIME --ntasks=$procs --job-name=$JOB.$size ../runsus.sh
    
done
