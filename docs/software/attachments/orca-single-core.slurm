#!/bin/bash
#SBATCH --job-name=ORCA-test-1-CPU
#SBATCH --mem-per-cpu=2GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 10:00:00
#SBATCH --partition=common
#SBATCH  --no-requeue
    
module load rocky8/all
module load orca/5.0.4
export orcadir=/gpfs/mariana/software/green/Orca/orca_5_0_3_openmpi_411/

#Create scratch directory
SCRATCH=/state/partition1/$SLURM_JOB_ID
mkdir -p $SCRATCH
cp  $SLURM_SUBMIT_DIR/* $SCRATCH/
cd $SCRATCH/

#Run calculations 
$orcadir/orca job.inp > $SLURM_SUBMIT_DIR/$job.log

cp $SCRATCH/* $SLURM_SUBMIT_DIR
       
#Clean after yourself
rm -rf  $SCRATCH
