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

