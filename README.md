The top level directories `courant-val` contain:

* `ups` file: this is a generic file that constitutes the base of the simulation.
            Use double angled brackets for values that you wish to change between runs `<<value you want to change>>`.
            these values will be set by `generate.sh`.
* `sus` : is a symbolic link to the executable.
* `runsus.sh`: contains all the necessary info required to submit `slurm` jobs. Modify this file as necessary.
* `extractData.sh`: is a bash script that parse and extract the data from `*.out` files and store them into the `outputs` directory. Also it runs the python script `dataFrameGen.py` that converts the results into `csv` format and store them in the directory `courant-val/csvData`. To run this script make sure that you have an activated python environment that have `pandas` installed. (no need to modify this file)  
* `dataFrameGen.py`: python script that transform the results in `outputs` to `csv` format.
* `cleanOutFiles`: is a script that cleans the `outputs` and `inputs` directory from automatically generated files. (THIS WILL CLEAN THE OUTPUT DATA FROM THE SIMULATION. BE CAREFULL!!)
* `RK3*`: are directories of the different cases that we want to run. every case directory must have the following structure:
    ```
    .
    ├── generate.sh
    ├── inputs/
    └── outputs/
    ```
* `generate.sh`: is the main file that you will have to modify to set mainly all the case files you see in `inputs`. Also it will trigger `runsus.sh` to submit all the `slurm` jobs for this case.

The following is the directory structure of this repo:

```
.
├── README.md
├── courant-0.2
│   ├── 3D-jet.ups
│   ├── RK300
│   │   ├── generate.sh
│   │   ├── inputs
│   │   │   ├── 1024.ups
│   │   │   ├── 128.ups
│   │   │   ├── 16.ups
│   │   │   ├── 2048.ups
│   │   │   ├── 256.ups
│   │   │   ├── 32.ups
│   │   │   ├── 4096.ups
│   │   │   ├── 512.ups
│   │   │   └── 64.ups
│   │   └── outputs
│   │       ├── RK300.1024.out
│   │       ├── RK300.128.out
│   │       ├── RK300.16.out
│   │       ├── RK300.256.out
│   │       ├── RK300.32.out
│   │       ├── RK300.512.out
│   │       ├── RK300.64.out
│   │       ├── extractScalingData
│   │       └── extractSolverScalingData
│   ├── RK311
│   │   ├── generate.sh
│   │   ├── inputs
│   │   │   ├── 1024.ups
│   │   │   ├── 128.ups
│   │   │   ├── 16.ups
│   │   │   ├── 2048.ups
│   │   │   ├── 256.ups
│   │   │   ├── 32.ups
│   │   │   ├── 4096.ups
│   │   │   ├── 512.ups
│   │   │   └── 64.ups
│   │   └── outputs
│   │       ├── RK311.1024.out
│   │       ├── RK311.128.out
│   │       ├── RK311.16.out
│   │       ├── RK311.256.out
│   │       ├── RK311.32.out
│   │       ├── RK311.512.out
│   │       ├── RK311.64.out
│   │       ├── extractScalingData
│   │       └── extractSolverScalingData
│   ├── cleanOutFiles
│   ├── dataFrameGen.py
│   ├── extractData.sh
│   ├── runsus.sh
│   └── sus -> /uufs/chpc.utah.edu/common/home/u1148465/development/builds/low-cost-cmake/release/StandAlone/sus
├── courant-0.4
│   ├── 3D-jet.ups
│   ├── RK310
│   │   ├── generate.sh
│   │   ├── inputs
│   │   │   ├── 1024.ups
│   │   │   ├── 128.ups
│   │   │   ├── 16.ups
│   │   │   ├── 2048.ups
│   │   │   ├── 256.ups
│   │   │   ├── 32.ups
│   │   │   ├── 4096.ups
│   │   │   ├── 512.ups
│   │   │   └── 64.ups
│   │   └── outputs
│   │       ├── RK310.1024.out
│   │       ├── RK310.128.out
│   │       ├── RK310.16.out
│   │       ├── RK310.256.out
│   │       ├── RK310.32.out
│   │       ├── RK310.512.out
│   │       ├── RK310.64.out
│   │       ├── extractScalingData
│   │       └── extractSolverScalingData
│   ├── RK311
│   │   ├── generate.sh
│   │   ├── inputs
│   │   │   ├── 1024.ups
│   │   │   ├── 128.ups
│   │   │   ├── 16.ups
│   │   │   ├── 2048.ups
│   │   │   ├── 256.ups
│   │   │   ├── 32.ups
│   │   │   ├── 4096.ups
│   │   │   ├── 512.ups
│   │   │   └── 64.ups
│   │   └── outputs
│   │       ├── RK311.1024.out
│   │       ├── RK311.128.out
│   │       ├── RK311.16.out
│   │       ├── RK311.256.out
│   │       ├── RK311.32.out
│   │       ├── RK311.512.out
│   │       ├── RK311.64.out
│   │       ├── extractScalingData
│   │       └── extractSolverScalingData
│   ├── cleanOutFiles
│   ├── dataFrameGen.py
│   ├── extractData.sh
│   ├── runsus.sh
│   └── sus -> /uufs/chpc.utah.edu/common/home/u1148465/development/builds/low-cost-cmake/release/StandAlone/sus
└── courant-0.8
    ├── 3D-jet.ups
    ├── RK301
    │   ├── generate.sh
    │   ├── inputs
    │   │   ├── 1024.ups
    │   │   ├── 128.ups
    │   │   ├── 16.ups
    │   │   ├── 2048.ups
    │   │   ├── 256.ups
    │   │   ├── 32.ups
    │   │   ├── 4096.ups
    │   │   ├── 512.ups
    │   │   └── 64.ups
    │   └── outputs
    │       ├── RK301.1024.out
    │       ├── RK301.128.out
    │       ├── RK301.16.out
    │       ├── RK301.256.out
    │       ├── RK301.32.out
    │       ├── RK301.512.out
    │       ├── RK301.64.out
    │       ├── extractScalingData
    │       └── extractSolverScalingData
    ├── RK311
    │   ├── generate.sh
    │   ├── inputs
    │   │   ├── 1024.ups
    │   │   ├── 128.ups
    │   │   ├── 16.ups
    │   │   ├── 2048.ups
    │   │   ├── 256.ups
    │   │   ├── 32.ups
    │   │   ├── 4096.ups
    │   │   ├── 512.ups
    │   │   └── 64.ups
    │   └── outputs
    │       ├── RK311.1024.out
    │       ├── RK311.128.out
    │       ├── RK311.16.out
    │       ├── RK311.256.out
    │       ├── RK311.32.out
    │       ├── RK311.512.out
    │       ├── RK311.64.out
    │       ├── extractScalingData
    │       └── extractSolverScalingData
    ├── cleanOutFiles
    ├── dataFrameGen.py
    ├── extractData.sh
    ├── runsus.sh
    └── sus -> /uufs/chpc.utah.edu/common/home/u1148465/development/builds/low-cost-cmake/release/StandAlone/sus

21 directories, 133 files
```