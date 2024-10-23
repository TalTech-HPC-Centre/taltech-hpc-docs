#!/bin/bash
#SBATCH --job-name=Job_Name
#SBATCH -t 1:00:00
#SBATCH  --no-requeue
#SBATCH --partition=gpu-test
#SBATCH --gres=gpu:A100:2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=160GB

module use /gpfs/mariana/modules/system
module load amp/all
module load Gaussian/16.c02


 SCRATCH=/state/partition1/$SLURM_JOB_ID
 export GAUSS_SCRDIR=$SCRATCH
 mkdir -p $SCRATCH

 g16 job.com > job.log

 #Clean after yourself
 rm -rf  $SCRATCH
