#!/bin/bash
#SBATCH --job-name=abaqus-jobname
#SBATCH -N 1 #The job requires 1 compute node
#SBATCH --ntasks=24
#SBATCH --ntasks-per-node=24 #The job requires 24 task per node
#SBATCH --mem=22GB #Memory for calculation
#SBATCH -p common
#SBATCH -t 150:00:00

### Load specific version of ABAQUS
module load green/all
module load abaqus/2018

### unset SLURM's Global Task ID for ABAQUS's PlatformMPI to work
unset SLURM_GTIDS

### Create ABAQUS environment file for current job, you can set/add your own options (Python syntax)
env_file=abaqus_v6.env

cat << EOF > ${env_file}
#verbose = 3
#ask_delete = OFF
mp_file_system = (SHARED, LOCAL)
mp_mode=THREADS
license_server_type=FLEXNET
abaquslm_license_file="27000@lic-simulia.intra.ttu.ee"
EOF

node_list=$(scontrol show hostname ${SLURM_NODELIST} | sort -u)

mp_host_list="["
for host in ${node_list}; do
    mp_host_list="${mp_host_list}['$host', ${SLURM_CPUS_ON_NODE}],"
done

mp_host_list=$(echo ${mp_host_list} | sed -e "s/,$/]/")

echo "mp_host_list=${mp_host_list}"  >> ${env_file}

### Set input file and job (file prefix) name here
job_name=${SLURM_JOB_NAME}
input_file=inputfile.psf

### ABAQUS parallel execution
abaqus script=${input_file} 
