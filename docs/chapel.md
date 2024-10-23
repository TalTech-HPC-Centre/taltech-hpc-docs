<span style="color:red">not changed to rocky yet</span>

# Chapel language for HPC


Special programming language developed for supercomputing, origially by the Cray Cascade project in DARPA's High Productivity Computing Systems (HPCS) program.


## modules

---

on amp

    module load amp
    module load llvm/14.0.0
    module load chapel/1.28
    module load amp-spack
    module load cuda/11.3.1-gcc-9.3.0-e4ej


on green

    module load green-spack/0.17.1
    module load gcc/10.3.0-gcc-10.3.0-qshu
    module load llvm/13.0.0-gcc-10.3.0-dhdd
    module load opempi/4.1.1-gcc-10.3.0



## evironment variables

---

on amp

    source /gpfs/mariana/software/amp/chapel/chapel-1.28.0/util/quickstart/setchplenv.bash
    
on green

    source /gpfs/mariana/software/green/chapel/chapel-1.28.0/util/quickstart/setchplenv.bash



Check which environments are available and compare to current settings

    $CHPL_HOME/util/chplenv/printchplbuilds.py

check current variables

     $CHPL_HOME/util/printchplenv

set some environment variables

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



    CHPL_COMM_SUBSTRATE=ibv        # several locales (nodes) with IB
    CHPL_COMM_SUBSTRATE=smp        # several locales within a single node
    CHPL_COMM_SUBSTRATE=mpi        # several locales (nodes) using MPI
    CHPL_COMM_SUBSTRATE=udp        # several locales (nodes) using 


    CHPL_LOCALE_MODEL=flat  #normal
    CHPL_LOCALE_MODEL=numa  #locale is subdevided into numa domains
    CHPL_LOCALE_MODEL=gpu   #for GPU

    CHPL_LAUNCHER_PARTITION=green-ib
    CHPL_LAUNCHER_PARTITION=gpu


## example chapel programs

---

can be copied from `$CHPL_HOME/examples`

set environment variables as needed

compile

    chpl -o jacobi-cpu-green jacobi-cpu.chpl

run the chapel program with apropriate number of locales (typically a locale is a full node!)

    ./jacobi-cpu-green -nl 1

the program can be started directly (without srun or sbatch), it uses the specified launcher set in the environment variable `CHPL_LAUNCHER=slurm-srun`


less threads on a node can be specified using the `CHPL_RT_NUM_THREADS_PER_LOCALE` environment variable

