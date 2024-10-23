<span style="color:red">not changed to rocky yet</span>

# cp2k

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## cp2k short introduction 

---

1. Make [cp2k.slurm](cp2k.slurm) batch script for parallel calculations:

```
    #!/bin/bash
    #SBATCH -p common
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=2         # CPU cores per MPI process
    #SBATCH --mem-per-cpu=1G          # host memory per CPU core
    #SBATCH --time=0-03:00            # time (DD-HH:MM)
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
    module load green/spack
    module load cp2k/8.2-gcc-10.3.0-7cv4
    srun cp2k.psmp -i H2O-32.inp -o H2O-32.out
```

2. Copy job-input file [H2O-32.inp](H2O-32.inp)
3. Submit the job on **base**:

           sbatch cp2k.slurm



<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## cp2k long version 

---

### Environment

Environment is set up by the commands:

        module load green-spack
        module load cp2k


### Running cp2k jobs

cp2k is MPI and SMP parallelized, it requires OpenMPI environment to be initialized, which means `mpirun` or `srun` need to be used to start it.


### Time


### Memory

#### How to cite:




## cp2k with GPUs on **amp**

---


The version 7.1 has a bug, use only a single MPI task and a single GPU,, for multiple MPI tasks and GPUs (1 GPU per ntask) use version 9.1!

Login to amp or amp2 using ssh (ssh-keys need to be configured)

    ssh amp2

initialize the environment

    source /usr/share/lmod/6.6/init/bash
    module use /gpfs/mariana/modules/system
    module load amp-spack/0.19.0
    module load ucx/1.13.0-gcc-9.3.0-5yyu
    module load openmpi/4.1.1-gcc-9.3-amp
    module load cp2k/7.1-gcc-9.3.0-openblas-m7xt


either run the job with srun

    srun -p gpu-test --gres=gpu:2 -n 2 --cpus-per-task=1 --mem=16G cp2k.psmp -i H2O-32.inp -o log-H2O-32


or better use the [cp2k-gpu.slurm](cp2k-gpu.slurm) script to submit the job:

    #!/bin/bash
    #SBATCH -p gpu-test
    #SBATCH --gres=gpu:3                  # total number of GPUs
    #SBATCH --ntasks=2
    ##SBATCH --ntasks-per-gpu=1        # total of 2 MPI processes
    #SBATCH --cpus-per-task=2         # CPU cores per MPI process
    #SBATCH --mem-per-cpu=5G          # host memory per CPU core
    #SBATCH --time=0-03:00            # time (DD-HH:MM)
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
    source /usr/share/lmod/6.6/init/bash
    module use /gpfs/mariana/modules/system
    module load amp-spack/0.19.0
    module load ucx/1.13.0-gcc-9.3.0-5yyu
    module load openmpi/4.1.1-gcc-9.3-amp
    module load cp2k/9.1-gcc-9.3.0-openblas-vgen
    
    srun cp2k.psmp -i H2O-32.inp -o log-H2O-32.out

