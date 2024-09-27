#!/bin/bash
#SBATCH --job-name DIST
#SBATCH --time 10:00
#SBATCH --exclusive
#SBATCH --cpus-per-task 60
#SBATCH --mem 64G
#SBATCH --partition small-g
#SBATCH --gpus-per-node 8

module load LUMI/22.08 partition/G
module load singularity-bindings
module load aws-ofi-rccl

export NCCL_SOCKET_IFNAME=hsn
export NCCL_NET_GDR_LEVEL=3
#export NCCL_DEBUG=INFO
export MIOPEN_USER_DB_PATH=/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export CXI_FORK_SAFE=1
export CXI_FORK_SAFE_HP=1
export FI_CXI_DISABLE_CQ_HUGETLB=1
export SINGULARITYENV_LD_LIBRARY_PATH=/opt/ompi/lib:${EBROOTAWSMINOFIMINRCCL}/lib:/opt/cray/xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta/lib64:${SINGULARITYENV_LD_LIBRARY_PATH}

export MASTER_ADDR=$(scontrol show hostname $SLURM_NODELIST | head -n1)
export OMP_NUM_THREADS=1

srun -J MOPREP mkdir -p $MIOPEN_CUSTOM_CACHE_DIR

# bind /appl 
srun -J Train singularity exec --rocm \
    -B /appl:/appl \
    -B "$SCRATCH":"$SCRATCH" \
    $SCRATCH/pytorch_latest.sif \
    torchrun --nnodes=$SLURM_NNODES \
    --nproc_per_node=$SLURM_GPUS_PER_NODE \
    --rdzv_id=$SLURM_JOB_ID \
    --rdzv_backend=c10d \
    --rdzv_endpoint=$MASTER_ADDR $@
