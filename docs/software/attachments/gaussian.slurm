#!/bin/bash
#SBATCH --job-name=Job_Name
#SBATCH --mem-per-cpu=2GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH -t 3-00:00:00
#SBATCH --partition=common
#SBATCH  --no-requeue

module load rocky8/all
module load gaussian/16.c02
    
    SCRATCH=/state/partition1/$SLURM_JOB_ID
    export GAUSS_SCRDIR=$SCRATCH
    mkdir -p $SCRATCH
     
    g16 -m=24gb -p=24 < job.com > job.log
        
#Clean after yourself
rm -rf  $SCRATCH 
