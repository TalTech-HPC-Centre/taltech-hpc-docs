# Finite Element Analysis

!!! warning
    This page has not been completely updated for Rocky 8 yet!

The following software is installed on the cluster:

- **ElmerFEM**: Multiphysics [ElmerModelsManual.pdf](http://www.nic.funet.fi/pub/sci/physics/elmer/doc/ElmerModelsManual.pdf)
- **CalculiX**: Mechanical analysis, heat, electromagnetic, CFD; solver makes use of the Abaqus input format. [Overview of the finite element capabilities of CalculiX Version 2.18](http://www.dhondt.de/ov_calcu.htm)
- **deal.ii** (via [SPACK](/software/spack)): A C++ software library supporting the creation of finite element codes and an open community of users and developers.
- **Abaqus**: Commercial
- **Comsol**: Commercial, License belongs to a research group (...)
- **code_aster** (upcoming from generic package)
- **ngsolve** (upcoming from source)

The following software is under consideration:

- **FEniCS** (under consideration) SPACK
- **Dune** (under consideration) source
- **FEATool Multiphysics** (under consideration) source
- **FreeFEM** (under consideration) SPACK
- **MFEM** (under consideration) SPACK
- **MoFEM** (under consideration) SPACK problematic

## ElmerFEM

Elmer is a multi-physics simulation software developed by CSC. It can perform coupled mechanical, thermal, fluid, and electromagnetic simulations and can be extended by custom equations.

- [Elmer homepage](http://www.elmerfem.org/blog/)
- [Elmer manuals and tutorials](https://www.nic.funet.fi/pub/sci/physics/elmer/doc/)

### Loading the module

To use ElmerFEM, the module needs to be loaded:

```bash
module load elmerfem-9.0
```

This makes the following main commands `ElmerGrid`, `ElmerSolver` available (and `ElmerGUI` can be used on viz to set up the case file). The use of ElmerGUI for simulations is **not** recommended.

### Running a tutorial case (quick-start for the impatient)

Copy the tutorial directory (here the linear elastic beam):

```bash
cp -r /share/apps/HPC2/ElmerFEM/tutorials-CL-files/ElasticEigenValues/ linear-elastic-beam-tutorial
cd linear-elastic-beam-tutorial
```

Start an interactive session on a node:

```bash
srun -t 2:00:00 --pty bash
```

Create the mesh:

```bash
ElmerGrid d 7 2 mesh.FDNEUT
```

Run the solver:

```bash
ElmerSolver
```

Postprocessing would be visualizing the `eigen_values.vtu` file in `paraview` on viz.

### Setting up a simulation (for new users)

The following steps are needed to configure a simulation case (mostly on base):

1. Create geometry in Gmsh, group and name physical volumes and surfaces (can be done on viz)
2. Create mesh in Gmsh (large meshes can be created from the CLI in a batch job: `gmsh -3 geometry.geo`)
3. Convert the mesh to Elmer's format using ElmerGrid, including scaling if needed: `ElmerGrid 14 2 geometry.msh -scale 0.001 0.001 0.001`
4. Create a new project in ElmerGUI (can be done on viz)
    - Create project
    - Load Elmer mesh (point to the created mesh directory)
    - Add equation(s)
    - Add material(s)
    - Add boundary conditions
    - Create sif
    - Edit & save sif
5. Edit the `case.sif` file (mesh directory, some other parameters [e.g. calculate PrincipalStresses] can only be added in the sif file, not in the GUI)
6. Run simulation `srun ElmerSolver` (or create batch file and submit using sbatch)
7. Postprocessing in ParaView (on viz)

### An example simulation case from start to finish

## CalculiX

The two programs that form CalculiX are `cgx` and `ccx`, where `cgx` is a graphical frontend (pre- and post-processing) and `ccx` is the solver doing the actual numerics.

As mentioned above, CalculiX uses the Abaqus format.

## Abaqus

## Comsol

The license belongs to the research group of ... . In case you need access, please agree with them on a cooperation.

## deal.ii

Available through a SPACK module.

```bash
module use /share/apps/HPC2/SPACK/spack/share/spack/modules/linux-centos7-skylake_avx512/
```

deal.ii is a C++ library that can be used to write custom FEA software.
