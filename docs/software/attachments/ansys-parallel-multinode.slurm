#!/bin/bash
#SBATCH --job-name=ansys-parallel
#SBATCH --ntasks=16
##SBATCH -N 1  #force single node
##SBATCH --ntasks-per-node=16  #force number of tasks per node
##SBATCH --cpus-per-task=2 #make sure 2 hyperthreads are allocated per task
#SBATCH --mem-per-cpu=2GB #alternative way to
#SBATCH -p common
#SBATCH -t 0:10:00

module load green/all
module load Ansys-AutoDyn/23.2

module list

### Configure variables, need to unset SLURM's Global Task ID for ABAQUS's PlatformMPI to work
#unset SLURM_GTIDS

## some debug output
echo "DEBUG: SLURM_NODELIST ${SLURM_JOB_NODELIST}"
echo "DEBUG: SLURM_MEM_PER_NODE $SLURM_MEM_PER_NODE"
echo "DEBUG: SLURM_JOB_CPUS_PER_NODE $SLURM_JOB_CPUS_PER_NODE"
echo "DEBUG: SLURM_NTASKS $SLURM_NTASKS"
echo "DEBUG: SLURM_CPUS_ON_NODE $SLURM_CPUS_ON_NODE"
echo "DEBUG: SLURM_MEM_PER_CPU $SLURM_MEM_PER_CPU"

################################################################################
## start of a lot of magic to create the parallel.cfg from SLURM parameters
env_file=parallel.cfg

cat << EOF > ${env_file}
#@EPDEF=/gpfs/mariana/software/green/Ansys/AutoDyn-install/v232/autodyn/bin/linx64
#@PPDEF ttucluster
#@PPCFG ttucluster
EOF

nodelist=$(scontrol show hostname $SLURM_JOB_NODELIST|tr '\n' ' ')
#echo "${nodelist} sp=1000"  >> ${env_file}
#echo "#@ mem=$SLURM_MEM_PER_NODE cpu=$SLURM_JOB_CPUS_PER_NODE task=$SLURM_NTASKS" >> ${env_file}

# Use , as list seperator
IFS=','
# Convert string to array
hcpus=($SLURM_JOB_CPUS_PER_NODE)
unset IFS

declare -a conv

# Expand compressed slurm array
for cpu in ${hcpus[@]}; do
    if [[ $cpu =~ (.*)\(x(.*)\) ]]; then
	# found compressed value
	value=${BASH_REMATCH[1]}
	factor=${BASH_REMATCH[2]}
	echo "DEBUG: cpus on several nodes $value"
	echo "DEBUG: amount of nodes with above cpus $factor"
	for j in $(seq 1 $factor); do
	    conv=( ${conv[*]} $value )
	done
    else
	echo "DEBUG: one node cpu count $cpu"
	conv=( ${conv[*]} $cpu )
    fi
done

nhost=0

#echo $conv 
#echo ${conv[*]}
#echo ${conv[@]};
IFS=' '
for node in $nodelist
do 
    declare -i cpuspernode=${conv[$nhost]};
    echo "$node sp=1000" >> ${env_file}
    if [ $SLURM_CPUS_PER_TASK -gt 0 ]; then
	declare -i taskspernode=$(echo "$cpuspernode/$SLURM_CPUS_PER_TASK" | bc)
	echo "taskspernode from cpus-per-node / cpus-per-task  $taskspernode"
    else
	declare -i taskspernode=$cpuspernode
	echo "taskspernode from cpus-per-node $taskspernode"
    fi
    if [ $SLURM_MEM_PER_CPU -gt 0 ]; then
	declare -i nodemem=$(echo "$SLURM_MEM_PER_CPU*$taskspernode|bc")
	echo "nodemem from --mem-per-cpu * tasks-per-node $nodemem"
    else
	declare -i nodemem=$SLURM_MEM_PER_NODE
	echo "nodemem from --mem $nodemem"
    fi
    echo "#@ mem=$nodemem cpu=$cpuspernode task=$taskspernode" >> ${env_file}
    #echo "#@ mem=$SLURM_MEM_PER_NODE cpu=$cpuspernode task=$taskspernode" >> ${env_file}
    let nhost+=1
done 
## end of the magic to create the parallel.cfg from SLURM parameters
################################################################################

# Start AUTODYN solver by specifying input file
autodyn232 -I inputfile
