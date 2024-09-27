#!/bin/bash

#SBATCH --job-name=NWChem
#SBATCH --mem=3GB
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH -t 1:00:00
#SBATCH --partition=green-ib

module load rocky8-spack
module load nwchem

#Create scratch directory
SCRATCH=/state/partition1/$SLURM_JOB_ID
mkdir -p $SCRATCH
cp  $SLURM_SUBMIT_DIR/*.nw $SCRATCH/
cd $SCRATCH/

nwchem  job.nw > job.out

#Copy files back to working directory
cp $SCRATCH/* $SLURM_SUBMIT_DIR

#Clean after yourself
rm -rf  $SCRATCH


