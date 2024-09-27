# SWAN

!!! warning
    This page has not been completely updated for Rocky 8 yet!

SWAN is a third-generation wave model for obtaining realistic estimates of wave parameters in coastal areas, lakes and estuaries from given wind, bottom and current conditions. The model is based on the wave action balance equation with sources and sinks. SWAN allows to use two types of grids (structured and unstructured) and nesting approach. SWAN is not recommended to use in on ocean scales.

Manual can be found [here](https://swanmodel.sourceforge.io/online_doc/swanuse/swanuse.html) and more about SWAN settings can be found [here](https://swanmodel.sourceforge.io/settings/settings.htm).

---

## Quickstart

1. Load the module

    ```bash
    module load green/all
    module load Swan
    ```

2. Copy the examples

    ```bash
    cp -r $SWANDIR/../Examples Swan-examples
    ```

3. Unpack one example

    ```bash
    cd Swan-examples
    tar xf refrac.tar.gz
    cd refrac
    ```

4. Download the [swan.slurm](/software/attachments/swan.slurm) script
5. Adjust `ntasks`, `nodes` and `cpus-per-task` and submit it:

    ```bash
    sbatch swan.slurm
    ```

    Contents of the `swan.slurm`:

    ```bash
    #!/bin/bash
    #SBATCH --partition=green-ib  ### Partition
    #SBATCH --job-name=Swan   ### Job Name           -J
    #SBATCH --time=00:10:00       ### WallTime           -t
    #SBATCH --nodes=1             ### Number of Nodes    -N 
    #SBATCH --ntasks-per-node=2   ### Number of tasks (MPI processes)
    #SBATCH --cpus-per-task=4     ### Number of threads per task (OMP threads)
    #SBATCH --mem-per-cpu=100     ### Min RAM required in MB

    #set up environment    
    module load green/all
    module load Swan

    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK        
    MACHINEFILE="machinefile"

    # Generate Machinefile for mpi such that hosts are in the same order as if run via srun
    srun -l /bin/hostname | sort -n | awk '{print $2}' > $MACHINEFILE

    # do the swan simulation
    swanrun -input a11refr.swn -mpi $SLURM_NTASKS -omp=$SLURM_CPUS_PER_TASK

    #rm $MACHINEFILE
    ```
