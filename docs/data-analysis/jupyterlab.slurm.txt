#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --time 01:30:00

#Load Python modules
module load rocky8-spack/
#module load green/all/
#module load r
module load julia
module load octave
module load py-jupyterlab
module load py-pip

echo $SLURM_JOB_NODELIST
module list

#Create Jupyter conf
cat << EOF > JupyterLab.conf.py
# Set ip to '*' to bind on all interfaces
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False

# It is a good idea to set a known, fixed port for server access
c.NotebookApp.port = 9900
EOF

#jupyter-lab --no-browser
jupyter-lab --no-browser --config=JupyterLab.conf.py

#Remove jupyter conf
rm JupyterLab.conf.py

