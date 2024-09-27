# xTB

---

## xTB Short Introduction

1. Create the [xtb.slurm](/software/attachments/xtb.slurm) batch script for parallel calculations:

    ```bash
    #!/bin/bash
    #SBATCH --job-name=xTB-test
    #SBATCH --mem=2GB
    #SBATCH --nodes=1
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=24
    #SBATCH -t 1-00:00:00
    #SBATCH --partition=common

    module load rocky8/all
    module load xtb-crest/6.7.0-crest3.0

    # Run calculations 
    xtb struc.xyz --opt tight --cycles 50 --charge -0 --alpb toluene --gfn 2 -P 4 > final.out
    ```

2. Copy the job input file [struc.xyz](/software/attachments/struc.xyz).
3. Submit the job on **base**:

    ```bash
    sbatch xtb.slurm
    ```

---

## xTB Long Version

---

Extended Tight Binding (xTB) is a program developed by Grimme's group for solving common chemical problems. The workhorses of xTB are the GFN methods, both semi-empirical and force-field. The program contains several implicit solvent models: GBSA, ALPB. xTB functionality covers single-point energy calculations, geometry optimization, frequency calculations, and reaction path methods. It also allows performing molecular dynamics, meta-dynamics, and ONIOM calculations. More about xTB on HPC can be found [here](https://xtb-docs.readthedocs.io/en/latest/index.html).

### Environment

The environment is set up with the commands:

```bash
module load rocky8/all
module load xtb-crest/6.7.0-crest3.0
```

### Running xTB Jobs

The input file should be in `.xyz` format and is executed by the command `xtb`. This command is usually placed in a `slurm` script.

```bash
xtb struc.xyz --opt tight --cycles 50 --charge -0 --alpb toluene --gfn 2 -P 4 > final.out
```

In xTB, calculation options are specified as command line arguments. `-P` is the number of processors used, `--gfn 2` is the calculation method (here GFN2-xTB), `--alpb toluene` is the ALPB implicit solvation model for toluene. More about [command line arguments](https://xtb-docs.readthedocs.io/en/latest/commandline.html).

### Time & Memory

Calculation time depends on the size of the molecule and the methods used, and can only be determined empirically.

1 GB per 2 or even more cores should be sufficient. For more detailed information, look at the `slurm-XXX-.stat` file after a test run. The lines "CPU Efficiency:" and "Memory Efficiency:" will give an idea of how efficiently the resources were used.

### How to Cite

The main publication for the xTB program - DOI: [10.1002/wcms.1493](https://wires.onlinelibrary.wiley.com/doi/10.1002/wcms.1493).
