<span style="color:red">not changed to rocky yet</span>

# CFD

**Computational Fluid Dynamics**

The following software is available:

- OpenFOAM
- STAR-CCM+ (commercial)
- code_saturne (upcoming)


The following software is under consideration:

- CONVERGE (commercial, free academic license, free training) https://convergecfd.com/




## OpenFOAM

### _Example use of OpenFOAM on the BASE cluster_

For the example we will use one of the tutorial cases.

    module load mpi/openmpi-x86_64
    source /share/apps/HPC2/OpenFOAM/OpenFOAM-v1912/etc/bashrc

First time users need to create their `$WM_PROJECT_USER_DIR`:

    mkdir $WM_PROJECT_USER_DIR --parent

copy the damBreak tutorial case into the `$WM_PROJECT_USER_DIR`:

    cp -r /share/apps/HPC2/OpenFOAM/OpenFOAM-v1912/tutorials/multiphase/interFoam/laminar/damBreak/damBreak $WM_PROJECT_USER_DIR/
    cd $WM_PROJECT_USER_DIR/damBreak
    pwd

Now we can run the OpenFOAM case step-by-step or as a batch job.

NB: Do *not* use the `Allrun` script(s) of the tutorials, as these may try to launch parallel jobs without requesting resources.



#### _Interactive single process_

For a non-parallel run of the tutorial case, the `decomposeParDict` needs to be removed:

    mv system/decomposeParDict system/decomposeParDict-save

Running the damBreak case step-by-step interactively:

    srun --partition=common -t 2:10:00 -−pty bash 
    source /share/apps/HPC2/OpenFOAM/OpenFOAM-v1912/etc/bashrc
    blockMesh
    setFields
    interFoam



#### _Batch-job (non-interactive) parallel job_

Alternatively, we can run the job in parallel as a batch job:
(If you removed/renamed the `decomposeParDict` before, copy  it back: `cp system/decomposeParDict-save system/decomposeParDict`)

The `openfoam.slurm` script:

    #!/bin/bash -l
    
    #SBATCH -n 4
    #SBATCH -t 00:10:00  
    #SBATCH -J openfoam-damBreak
    # #SBATCH --partition=green-ib
    
    #the following 2 lines are only needed if not done manually in command-line
    module load mpi/openmpi-x86_64
    source /share/apps/HPC2/OpenFOAM/OpenFOAM-v1912/etc/bashrc
    
    blockMesh
    decomposePar
    setFields
    mpirun interFoam -parallel
    reconstructPar

and then run in the command-line (`module` and `source` are only needed if not in sbatch script):

    module load mpi/openmpi-x86_64
    source /share/apps/HPC2/OpenFOAM/OpenFOAM-v1912/etc/bashrc
    sbatch openfoam.slurm


#### Pre-processing (geometry and mesh generation)

The geometry and mesh can be either hand-coded using **blockMesh** or with **Gmsh**, **FreeCAD** or **Salome**. When using Gmsh, be sure to save the mesh in v2 ASCII format (see separate page on [CAD-mesh](cad-mesh.md). This creates a volume mesh

To convert a Gmsh volume .msh file for OpenFOAM, use

    gmshToFoam meshfile.msh

Another possibility is to use CAD for a surface mesh and use the snappyHexMesh utility to adapt a blockMesh volume mesh to the surface (see OpenFOAM motorcycle tutorial).



#### Visualizing the results (post-processing)

Login to viz, change to the case directory, create an empty .foam file for the case

    touch damBreak.foam

and then use the regular ParaView 

    paraview

and open the .foam file from the menu




#### Comparison of the execution time

It is educational to check the runtime of the code using the `time` command, e.g. for the single-thread

    time interFoam

and for the parallel run (in the `openfoam.slurm` script)

    time mpirun -n $SLURM_NTASKS interFoam -parallel

As the damBreak case is quite small, it is likely that the parallel run is not faster than the sequential, due to the communication overhead.

In a testrun, the resuls have been as follows:

| time type | sequential | parallel  |
|-----------|------------|-----------|
| real      |  0m8.319s  | 0m39.463s |
| user      |  0m6.927s  | 1m1.755s  |
| sys       |  0m0.432s  | 0m2.922s  |


Lesson to be learned: Parallel computation is only useful for sufficiently large jobs.



**NOTE: Parallel does not (necessarily) mean faster!!!** Parallel execution introduces overhead (starting threads, communication)! For optimal execution time and optimal use of resources one needs to test and find the sweet spot.

![sweet spot](of-timing.png)![sweet spot](of-timing2.png)![sweet spot](of-timing4.png)

The division into the areas is a combined decision taking into account "real" (wall clock) and "user" (summed time of all threads) time (from the `time` command). "Wall clock" (real) time is the time one needs to wait till the job is finished, "Summed thread time" (user) is the sum of the times that all individual threads needed, it should be roughly user = numtreads x real. For parallel programs, one can expect that "user" time of the parallel run is larger than for the sequential, due to communication overhead, if it is smaller, that probably means the individual threads could make better use of cache.

| area | why | explanation |
|-----------|------------|-----------|
| sweet spot | minimal "user" time | = minimal heat production, optimal use of resources |
| good range | linear speedup for "real", with constant or slightly increasing "user" | |
| OK range | slightly less than linear speedup for "real", and slightly increasing "user" | |
| avoid | ascending slope in the diagram for "real" and "user" | one actually needs to wait longer compared to the case with fewer cores |


Recommended in *this* case would be to request 8 threads `-n 8 --ntasks-per-node 8` but use `mpirun -n 4`. OpenFOAM does not seem to benefit from hyperthreading.


## STAR-CCM+

Commercial license belonging to ...

