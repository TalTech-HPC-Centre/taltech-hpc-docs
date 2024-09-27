#!/bin/bash
#SBATCH --job-name=ORCA-test
#SBATCH --mem=48GB
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH -t 1-00:00:00
#SBATCH --partition=common
#SBATCH  --no-requeue

 module load rocky8/all
 module load orca/5.0.4
 module load openmpi  
 export orcadir=/gpfs/mariana/software/green/Orca/orca_5_0_4_openmpi_411/

 #Create scratch directory
 SCRATCH=/state/partition1/$SLURM_JOB_ID
 mkdir -p $SCRATCH
 cp  $SLURM_SUBMIT_DIR/* $SCRATCH/
 cd $SCRATCH/

 #Run calculations 
 $orcadir/orca job.inp > $SLURM_SUBMIT_DIR/job.log

 #Copy files back to working directory
 cp $SCRATCH/* $SLURM_SUBMIT_DIR

 #Clean after yourself
 rm -rf  $SCRATCH

    
