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

