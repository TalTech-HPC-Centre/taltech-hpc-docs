#!/bin/bash
#SBATCH --job-name=ansys-parallel
#SBATCH -N 1
#SBATCH --ntasks=16
##SBATCH --ntasks-per-node=16 
#SBATCH --mem=22GB #Memory for calculation
##SBATCH --mem-per-cpu=2GB #alternative memory specification on a per-cpu base
#SBATCH -p common
#SBATCH -t 0:10:00

module load green/all
module load Ansys-AutoDyn/23.2

### Configure variables, need to unset SLURM's Global Task ID for ABAQUS's PlatformMPI to work
#unset SLURM_GTIDS

env_file=parallel.cfg

cat << EOF > ${env_file}
#@EPDEF=/gpfs/mariana/software/green/Ansys/AutoDyn-install/v232/autodyn/bin/linx64
#@PPDEF ttucluster
#@PPCFG ttucluster
EOF

echo "SLURM_NODELIST ${SLURM_JOB_NODELIST}"
node_list=$(scontrol show hostname ${SLURM_JOB_NODELIST} | sort -u)
echo "${node_list} sp=1000"  >> ${env_file}
echo "SLURM_MEM_PER_NODE $SLURM_MEM_PER_NODE"
echo "SLURM_JOB_CPUS_PER_NODE $SLURM_JOB_CPUS_PER_NODE"
echo "SLURM_NTASKS $SLURM_NTASK"
echo "SLURM_CPUS_ON_NODE $SLURM_CPUS_ON_NODE"
echo "SLURM_MEM_PER_CPU $SLURM_MEM_PER_CPU"
echo "#@ mem=$SLURM_MEM_PER_NODE cpu=$SLURM_JOB_CPUS_PER_NODE task=$SLURM_NTASKS" >> ${env_file}


# Start AUTODYN solver by specifying input file
autodyn232 -I inputfile

