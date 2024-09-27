# Chapel language for HPC

!!! warning
    This page has not been completely updated for Rocky 8 yet!

Special programming language developed for supercomputing, originally by the Cray Cascade project in DARPA's High Productivity Computing Systems (HPCS) program.

## Modules

---

### On AMP

```bash
module load amp
module load llvm/14.0.0
module load chapel/1.28
module load amp-spack
module load cuda/11.3.1-gcc-9.3.0-e4ej
```

### On Green

```bash
module load green-spack/0.17.1
module load gcc/10.3.0-gcc-10.3.0-qshu
module load llvm/13.0.0-gcc-10.3.0-dhdd
module load opempi/4.1.1-gcc-10.3.0
```

## Environment Variables

---

### On AMP

```bash
source /gpfs/mariana/software/amp/chapel/chapel-1.28.0/util/quickstart/setchplenv.bash
```

### On Green

```bash
source /gpfs/mariana/software/green/chapel/chapel-1.28.0/util/quickstart/setchplenv.bash
```

Check which environments are available and compare to current settings:

```bash
$CHPL_HOME/util/chplenv/printchplbuilds.py
```

Check current variables:

```bash
$CHPL_HOME/util/printchplenv
```

Set some environment variables:

```bash
CHPL_TASKS=fifo
CHPL_GMP=none
CHPL_TARGET_CPU=native
CHPL_COMM=gasnet
CHPL_COMM_SUBSTRATE=ibv
CHPL_TARGET_COMPILER=gnu
CHPL_RE2=none
CHPL_LLVM=none
CHPL_LAUNCHER_PARTITION=green-ib
CHPL_SANITIZE=
CHPL_HOME=/gpfs/mariana/software/green/chapel/chapel-1.28.0
CHPL_LAUNCHER=slurm-srun
CHPL_LAUNCHER_NODE_ACCESS=unset
CHPL_MEM=jemalloc
```

```bash
CHPL_COMM_SUBSTRATE=ibv        # several locales (nodes) with IB
CHPL_COMM_SUBSTRATE=smp        # several locales within a single node
CHPL_COMM_SUBSTRATE=mpi        # several locales (nodes) using MPI
CHPL_COMM_SUBSTRATE=udp        # several locales (nodes) using 
```

```bash
CHPL_LOCALE_MODEL=flat  # normal
CHPL_LOCALE_MODEL=numa  # locale is subdivided into NUMA domains
CHPL_LOCALE_MODEL=gpu   # for GPU
```

```bash
CHPL_LAUNCHER_PARTITION=green-ib
CHPL_LAUNCHER_PARTITION=gpu
```

## Example Chapel Programs

---

Can be copied from `$CHPL_HOME/examples`.

Set environment variables as needed.

Compile:

```bash
chpl -o jacobi-cpu-green jacobi-cpu.chpl
```

Run the Chapel program with appropriate number of locales (typically a locale is a full node!):

```bash
./jacobi-cpu-green -nl 1
```

The program can be started directly (without `srun` or `sbatch`), it uses the specified launcher set in the environment variable `CHPL_LAUNCHER=slurm-srun`.

Less threads on a node can be specified using the `CHPL_RT_NUM_THREADS_PER_LOCALE` environment variable.
