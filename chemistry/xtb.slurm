#!/bin/bash
#SBATCH --job-name=xTB-test
#SBATCH --mem=2GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH -t 1-00:00:00
#SBATCH --partition=common

    module load rocky8/all
    module load xtb-crest/6.7.0-crest3.0
  
    #Run calculations 
    xtb struc.xyz --opt tight --cycles 50 --charge -0 --alpb toluene --gfn 2 -P 4 > final.out


    
