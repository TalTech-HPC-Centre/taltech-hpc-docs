#!/bin/bash
#SBATCH --job-name=CREST-test
#SBATCH --mem-per-cpu=1GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH -t 1-00:00:00
#SBATCH --partition=common

    module load rocky8/all
    module load xtb-crest
  
    #Run calculations 
    crest geometry.xyz --gfn2 --T 24 > final.out

    
