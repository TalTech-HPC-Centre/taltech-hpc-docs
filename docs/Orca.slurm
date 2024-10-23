#!/bin/bash
#SBATCH --job-name=Job_Name
#SBATCH --mem-per-cpu=1GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 15-00:00:00
#SBATCH --partition=common
    
module use /gpfs/mariana/modules/green/ALL/
module load orca/5.0.3
export orcadir=/gpfs/mariana/software/green/Orca/orca_5_0_3_openmpi_411/

#Create scratch directory
SCRATCH=/state/partition1/$SLURM_JOB_ID
mkdir -p $SCRATCH
cp  $SLURM_SUBMIT_DIR/*.inp $SCRATCH/
cd $SCRATCH/

#Run calculations 
$orcadir/orca job.inp > job.out

cp $SCRATCH/* $SLURM_SUBMIT_DIR
       
#Clean after yourself
rm -rf  $SCRATCH
