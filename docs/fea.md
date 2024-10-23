<span style="color:red">not changed to rocky yet</span>

# FEA

**Finite Element Analysis**

The following software is installed on the cluster:

- ElmerFEM: Multiphysics [ElmerModelsManual.pdf](http://www.nic.funet.fi/pub/sci/physics/elmer/doc/ElmerModelsManual.pdf)
- CalculiX: Mechanical analysis, heat, electromagnetic, CFD; solver makes use of the Abaqus input format. [Overview of the finite element capabilities of CalculiX Version 2.18](http://www.dhondt.de/ov_calcu.htm)
- deal.ii (via [SPACK](spack.md)): A C++ software library supporting the creation of finite element codes and an open community of users and developers.
- Abaqus: Commercial
- Comsol: Commercial, License belongs to a research group (...)
- code_aster (upcoming from generic package)
- ngsolve (upcoming from source)

The following software is under consideration:

- FEniCS (under consideration) SPACK
- Dune (under consideration) source
- FEATool Multiphysics (under consideration) source
- FreeFEM (under consideration) SPACK
- MFEM (under consideration) SPACK
- MoFEM (under consideration) SPACK problematic


## ElmerFEM

Elmer is a multi-physics simulation software developed by CSC. It can perform coupled mechanical, thermal, fluid, electro-magnetic simulations and can be extended by own equations.

Elmer homepage: [http://www.elmerfem.org/blog/](http://www.elmerfem.org/blog/)
Elmer manuals and tutorials: [https://www.nic.funet.fi/pub/sci/physics/elmer/doc/](https://www.nic.funet.fi/pub/sci/physics/elmer/doc/)



### _Loading the module_

To use ElmerFEM the module needs to be loaded

    module load elmerfem-9.0

This makes the following main commands `ElmerGrid`, `ElmerSolver` available (and `ElmerGUI` can be used on viz to setup the case file). The use of ElmerGUI for simulations is **not** recommended.


### _Running a tutorial case (quick-start for the impatient)_

Copy the tutorial directory (here the linear elastic beam):

    cp -r /share/apps/HPC2/ElmerFEM/tutorials-CL-files/ElasticEigenValues/ linear-elastic-beam-tutorial
    cd linear-elastic-beam-tutorial

Start an interactive session on a node

    srun -t 2:00:00 --pty bash

Create the mesh

    ElmerGrid d 7 2 mesh.FDNEUT

run the solver

    ElmerSolver

Postprocessing would be visualizing the `eigen_values.vtu` file in `paraview` on viz.




### _Setting up a simulation (for new users)_

The follwing steps are needed to configure a simulation case (mostly on base):

1. Create geometry in Gmsh, group and name physical volumes and surfaces (can be done on viz)
2. Create mesh in Gmsh (large meshes can be created from the CLI in a batch job: `gmsh -3 geometry.geo`)
3. Convert the mesh to elmer's format using ElmerGrid, including scaling if needed: `ElmerGrid 14 2 geometry.msh -scale 0.001 0.001 0.001
4. Create a new project in ElmerGUI (can be done on viz)
    - create project
    - load Elmer mesh (point to the created mesh directory)
    - add equation(s)
    - add material(s)
    - add boundary conditions
    - create sif
    - edit & save sif
5. Edit the `case.sif` file (mesh directory, some other parameters [e.g. calculate PrincipalStresses] can only be added in the sif file, not in the GUI)
6. run simulation `srun ElmerSolver` (or create batch file and submit using sbatch)
7. Postprocessing in ParaView (on viz)


### _An example simulation case from start to finish_



## CalculiX

The two programs that form CalculiX are `cgx` and `ccx`, where `cgx` is a graphical frontend (pre- and post-processing) and `ccx` is the solver doing the actual numerics.

As mentioned above, CalculiX uses the Abaqus format.



## Abaqus




## Comsol

The license belongs to the research group of ... . In case you need access, please agree with them on a cooperation.


## deal.ii

Available through a SPACK module.

    module use /share/apps/HPC2/SPACK/spack/share/spack/modules/linux-centos7-skylake_avx512/

deal.ii is a C++ library that can be used to write own FEA software.
