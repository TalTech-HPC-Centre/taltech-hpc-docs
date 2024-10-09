# TURBOMOLE

!!! warning
    This page has not been completely updated for Rocky 8 yet!
    This page is a work in progress!

!!! info
    To run TURBOMOLE, user must be a member of the TURBOMOLE user group or have purchased TURBOMOLE licenses.

## TURBOMOLE short introduction

---

1. Set up the environment and generate the TURBOMOLE coordinate file:

    ```bash
    module load turbomole7.0
    x2t inputfile.xyz > start-coord
    ```

2. Run ***define*** to create the input files needed.

3. Use the TURBOMOLE batch script:

    ```bash
    #!/bin/bash
    #SBATCH --nodes=1
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=1
    #SBATCH --job-name=test
    #SBATCH --mem-per-cpu=1GB
    #SBATCH -t 1:00:00
    #SBATCH --partition=common 

    module load turbomole7.0

    # Directory where you run the script
    CALCULATIONDIR=`pwd`

    # Create scratch directory
    SCRATCHDIRNAME=/state/partition1/$SLURM_JOBID
    mkdir $SCRATCHDIRNAME
    cp * $SCRATCHDIRNAME
    cd $SCRATCHDIRNAME 

    # Run calculations 
    jobex -ri > jobex.out 2>jobex.err  # TURBOMOLE commands
    t2x -c > final.xyz

    # Clean after yourself
    mv $SCRATCHDIRNAME/* $CALCULATIONDIR 
    rm -rf $SCRATCHDIRNAME
    ```

4. Submit the job:

    ```bash
    sbatch TURBOMOLE.slurm
    ```

***NB!*** _More cores do not mean faster!!! See Benchmarks._

## TURBOMOLE long version

---

### Environment

There are currently several versions of TURBOMOLE (6.3 - 7.0) available on HPC, and most of them can be run as parallel jobs. The environment is set up by the command:

```bash
module load turbomole7.0
module load turbomole7.0-mpi    # for parallel run 
```

### Running TURBOMOLE jobs

TURBOMOLE uses its own coordinate file `coord`, which can be generated from a .xyz file by the TURBOMOLE command (when some TURBOMOLE version is already loaded):

```bash
x2t inputfile.xyz > start-coord
```

Example of TURBOMOLE coordinate file:

```plaintext
$coord
1.27839972889714      0.80710203135546      0.00041573974923       c
1.42630859331810      2.88253155131977      0.00372276048178       h
3.06528696563114     -0.57632867600746     -0.00069919866917       o
-1.91446264796512     -0.31879679861781      0.00039684248791       s
-2.98773260513752      1.98632893279876     -0.00701088395301       h
$end
```

In addition to the coordinate file, TURBOMOLE uses a special interactive program `define` to create the input files, which determine molecules' parameters, levels of theory used, and calculation types.  

```bash
define
```

The answers to `define`'s questions can be presented as a separate file. More about `define` can be read from the [TURBOMOLE tutorial](/software/attachments/Turbomole_Tutorial_7-0.pdf). Some examples of define files can be found [here](/software/define).

To include solvent effects into calculations, the interactive program `cosmoprep` should be run after `define`.

```bash
cosmoprep 
```

TURBOMOLE includes the Conductor-like Screening Model (COSMO), where the solvent is described as a dielectric continuum with permittivity ε.

After input files are created, TURBOMOLE calculations are executed by one of the following commands: `dscf`, `ridft`, `jobex`, `aoforce`, `NumForce`, `escf`, `egrad`, `mpshift`, `raman`, `ricc2`, etc. For example:

```bash
dscf           # for Hartree-Fock energy calculation (single point calculation)
jobex -ri      # geometry optimization using RI-approximation
aoforce        # analytical force constant calculations
NumForce -ri   # numerical force constant calculations using RI-approximation
```

More about TURBOMOLE commands used can be found in [TURBOMOLE tutorial](/software/attachments/Turbomole_Tutorial_7-0.pdf).

### Single core calculations

Example of a Slurm script for single point HF calculation performed on a single core:

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --job-name=test
#SBATCH --mem-per-cpu=1GB
#SBATCH -t 1:00:00
#SBATCH --partition=common 

module load turbomole7.0

# Directory where you run the script
CALCULATIONDIR=`pwd`

# Create scratch directory
SCRATCHDIRNAME=/state/partition1/$SLURM_JOBID
mkdir $SCRATCHDIRNAME

cp * $SCRATCHDIRNAME
cd $SCRATCHDIRNAME 

# Run calculations 
dscf > JOB.out 2>JOB.err  

# Clean after yourself
mv $SCRATCHDIRNAME/* $CALCULATIONDIR 
rm -rf $SCRATCHDIRNAME
```

### Parallel jobs SMP

Example of a Slurm script for geometry optimization using RI-approximation performed by SMP run:

```bash
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --job-name=test
#SBATCH --mem-per-cpu=1GB
#SBATCH -t 1:00:00
#SBATCH --partition=common 

module load turbomole7.0-mpi

# Directory where you run the script
CALCULATIONDIR=`pwd`

# Create scratch directory
SCRATCH=/state/partition1/$SLURM_JOBID
mkdir $SCRATCH

cp * $SCRATCH
cd $SCRATCH 

export PARA_ARCH=SMP
export PATH=$TURBODIR/bin/`sysname`:$PATH 
export PARNODES=$SLURM_NTASKS 
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Run calculations 
jobex -ri -c 600 > jobex.out 2>jobex.err 
t2x -c > final.xyz

# Clean after yourself
mv $SCRATCH/* $CALCULATIONDIR 
rm -rf $SCRATCH
```

### Memory

For common calculations (e.g. optimization, frequency, etc.) it is enough 1 GB per 1 CPU. However, some calculations can require more memory (e.g. TD-DFT, large SCF calculations, etc.). Data from a `slurm-JOBID.stat` file can be useful to determine the amount of memory required for a computation. In the `slurm-JOBID.stat` file, the efficiency of memory utilization is shown.

Bad example:

```plaintext
Memory Utilized: 3.08 GB 
Memory Efficiency: 11.83% of 26.00 GB
```

Good example:

```plaintext
Memory Utilized: 63.12 GB 
Memory Efficiency: 98.62% of 64.00 GB
```

### Time

Time limits depend on the time partition used [taltech user-guides](/access/hardware). If the calculation time exceeds the time limit requested in the Slurm script, then the job will be killed. Therefore, it is recommended to request a little more than is usually needed for the calculation.

### Restarting a failed/interrupted calculation

All TURBOMOLE jobs are restart jobs by default.
