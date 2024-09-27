#!/bin/bash
#SBATCH --partition=green-ib  
#SBATCH --job-name=Swan               
#SBATCH --time=00:10:00                 
#SBATCH --nodes=1              
#SBATCH --ntasks-per-node=7   
#SBATCH --cpus-per-task=4     
#SBATCH --mem-per-cpu=100     

module load green/all

module load Swan

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

MACHINEFILE="machinefile"
# Generate Machinefile for mpi such that hosts are in the same
#  order as if run via srun

srun -l /bin/hostname | sort -n | awk '{print $2}' > $MACHINEFILE
#swanrun ...
#rm $MACHINEFILE

swanrun -input a11refr.swn -mpi $SLURM_NTASKS


