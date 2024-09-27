#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=test
#SBATCH --mem=2GB
#SBATCH -t 1:00
#SBATCH --partition=short

module load grocky8/all
module load MultiWFN/3.7 

Multiwfn  file-name.wfn << EOF > /dev/null
2
2
-4
6
0
-10
100
2
1
mol.pdb
q
EOF
