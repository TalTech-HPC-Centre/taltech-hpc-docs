# LUMI Slurm Usage Examples

Like at HPC, at LUMI, computing resources are allocated to the user by the resource manager Slurm. More about Slurm scripts at LUMI can be found [here](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/slurm-quickstart/).

- At LUMI, partitions can be allocated by [node](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/partitions/#slurm-partitions-allocatable-by-node) or by [resources](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/partitions/#slurm-partitions-allocatable-by-resources).

- **The user always has to specify the account.** It is mandatory!

    Account specification can be done by adding into the Slurm script `#SBATCH --account=project_XXX` line or by adding the following two lines into the `.bashrc` file by command:

    ```bash
    cat <<EOT > .bashrc
    export SBATCH_ACCOUNT=project_XXX
    export SALLOC_ACCOUNT=project_XXX
    EOT
    ```

    where `XXX` is a project number which can be found in [ETAIS](https://etais.ee) as `Effective ID`.

- By default, **upon node failure, the job will be automatically resubmitted to the queue** with the same job ID and that will truncate the previous output. To avoid this, add the following two lines into the `.bashrc` file by command:

    ```bash
    cat <<EOT > .bashrc
    SBATCH_NO_REQUEUE=1 
    SBATCH_OPEN_MODE=append
    EOT
    ```

More about Slurm options can be found in [LUMI manuals](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/batch-job/#common-slurm-options).

Slurm script examples provided by LUMI:

- [GPU jobs](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/)
- [CPU jobs](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumic-job/)
- [Job array](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/throughput/)

## Multi-Node Multi-GPU PyTorch Training

---

This PyTorch script simulates training a ResNet model across multiple GPUs and nodes.

### Quick Guide

1. Download:
      - environment setup script - [env.sh](/access/attachments/env.sh)
      - bash script to set up Singularity - [setup.sh](/access/attachments/setup.sh)
      - PyTorch script - [min_dist.py](/access/attachments/min_dist.py)
      - Slurm script - [dist_run.slurm](/access/attachments/dist_run.slurm)

2. Set up the environment by command:

    ```bash
    . env.sh project_XXX 
    ```

    where `XXX` is a project number.

3. Set up Singularity:

    ```bash
    ./setup.sh 
    ```

4. Run the PyTorch script:

    ```bash
    sbatch -N 2 dist_run.slurm min_dist.py
    ```

5. You should get an output file `slurm_job-number` with content like:

    ```text
    8 GPU processes in total
    Batch size = 128
    Dataset size = 50000
    Epochs = 5

    Epoch 0  done in 232.64820963301463s
    Epoch 1  done in 31.191600811027456s
    Epoch 2  done in 31.244039460027125s
    Epoch 3  done in 31.384101407951675s
    Epoch 4  done in 31.143528194981627s
    ```

### Detailed Guide

Download:

- environment setup script - [env.sh](/access/attachments/env.sh)
- bash script to set up Singularity - [setup.sh](/access/attachments/setup.sh)
- PyTorch script - [min_dist.py](/access/attachments/min_dist.py)
- Slurm script - [dist_run.slurm](/access/attachments/dist_run.slurm)

#### Setup

These commands will set up the environment and Singularity:

```bash
. env.sh project_XXX
./setup.sh
```

where `XXX` is a project number that should be changed according to the user's project number.

#### Running

The job can be submitted into the queue by command:

```bash
sbatch -N 2 dist_run.slurm min_dist.py
```

Where `dist_run.slurm` is a resource manager, `min_dist.py` is a PyTorch script, and `-N` is the number of nodes used.

```bash
#!/bin/bash
#SBATCH --job-name=DIST
#SBATCH --time=10:00
#SBATCH --mem 64G
#SBATCH --cpus-per-task 32
#SBATCH --partition small-g
#SBATCH --gpus-per-node 4

export NCCL_SOCKET_IFNAME=hsn
export NCCL_NET_GDR_LEVEL=3

export CXI_FORK_SAFE=1
export CXI_FORK_SAFE_HP=1
export FI_CXI_DISABLE_CQ_HUGETLB=1

export MIOPEN_USER_DB_PATH=/tmp/${USER}-miopen-cache-${SLURM_JOB_ID}
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}

export MASTER_ADDR=$(scontrol show hostname $SLURM_NODELIST | head -n1)

export OMP_NUM_THREADS=8

srun singularity exec --rocm \
        $SCRATCH/pytorch_latest.sif \
        torchrun --nnodes=$SLURM_NNODES \
        --nproc_per_node=$SLURM_GPUS_PER_NODE \
        --rdzv_id=$SLURM_JOB_ID \
        --rdzv_backend=c10d \
        --rdzv_endpoint=$MASTER_ADDR $@
```

The environment variables containing `NCCL` and `CXI` are used by RCCL for communication over Slingshot.

The ones containing `MIOPEN` are for [MIOpen](https://rocmsoftwareplatform.github.io/MIOpen/doc/html/index.html) to create its caches in the `/tmp` (which is local to each node and in memory). If this is not set, then MIOpen will create its cache in the user home directory (the default), which is a problem since each node needs its own cache.

