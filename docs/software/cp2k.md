# cp2k

!!! warning
    This page has not been completely updated for Rocky 8 yet!

## CP2K Short Introduction

1. Create a [cp2k.slurm](/software/attachments/cp2k.slurm) batch script for parallel calculations:

    ```bash
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

2. Copy the job input file [H2O-32.inp](/software/attachments/H2O-32.inp).
3. Submit the job on **base**:

    ```bash
    sbatch cp2k.slurm
    ```

## CP2K Long Version

### Environment

The environment is set up by the commands:

```bash
module load green-spack
module load cp2k
```

### Running CP2K Jobs

CP2K is MPI and SMP parallelized; it requires the OpenMPI environment to be initialized, which means `mpirun` or `srun` needs to be used to start it.

## CP2K with GPUs on **amp**

---

Version 7.1 has a bug; use only a single MPI task and a single GPU. For multiple MPI tasks and GPUs (1 GPU per task), use version 9.1!

Log in to amp or amp2 using SSH (SSH keys need to be configured):

```bash
ssh amp2
```

Initialize the environment:

```bash
source /usr/share/lmod/6.6/init/bash
module use /gpfs/mariana/modules/system
module load amp-spack/0.19.0
module load ucx/1.13.0-gcc-9.3.0-5yyu
module load openmpi/4.1.1-gcc-9.3-amp
module load cp2k/7.1-gcc-9.3.0-openblas-m7xt
```

Either run the job with `srun`:

```bash
srun -p gpu-test --gres=gpu:2 -n 2 --cpus-per-task=1 --mem=16G cp2k.psmp -i H2O-32.inp -o log-H2O-32
```

Or better, use the [cp2k-gpu.slurm](/software/attachments/cp2k-gpu.slurm) script to submit the job:

```bash
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
```
