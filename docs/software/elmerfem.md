# ElmerFEM

!!! warning
    This page is a work in progress!

Elmer is a multi-physics simulation software developed by CSC. It can perform coupled mechanical, thermal, fluid, electro-magnetic simulations and can be extended by own equations.

Some useful links:

- Elmer homepage: [http://www.elmerfem.org/blog/](http://www.elmerfem.org/blog/)
- Elmer manuals and tutorials: [https://www.nic.funet.fi/pub/sci/physics/elmer/doc/](https://www.nic.funet.fi/pub/sci/physics/elmer/doc/)

## How to cite

*CSC – IT CENTER FOR SCIENCE LTD., 2020. Elmer, Available at: [https://www.csc.fi/web/elmer/](https://www.csc.fi/web/elmer/).*

---

## Loading the module

To use ElmerFEM the module needs to be loaded:

```bash
module load rocky8-spack    
module load elmerfem/9.0-gcc-10.3.0-netlib-lapack-qjdi
```

This makes the following main commands `ElmerGrid`, `ElmerSolver` available and `ElmerGUI` can be used with X11 forwarding or in an OnDemand desktop session to setup the case file. The use of ElmerGUI to run simulations is **not** recommended.

---

## Running a tutorial case (quick-start for the impatient)

1. Copy the tutorial directory (here the linear elastic beam) and go into it:

    ```bash
    cp -r /share/apps/HPC2/ElmerFEM/tutorials-CL-files/ElasticEigenValues/ linear-elastic-beam-tutorial
    cd linear-elastic-beam-tutorial
    ```

2. Start an interactive session on a node:

    ```bash
    srun -t 2:00:00 --pty bash
    ```

3. Create the mesh:

    ```bash
    ElmerGrid d 7 2 mesh.FDNEUT
    ```

4. Run the solver:

    ```bash
    ElmerSolver
    ```

5. Postprocessing would be visualizing the `eigen_values.vtu` file in `paraview`.

---

## Setting up a simulation (for new users)

The following steps are needed to configure a simulation case (mostly on **base**).

1. Create geometry in Gmsh, group and name physical volumes and surfaces (can be done on **viz**).

2. Create mesh in Gmsh (large meshes can be created from the CLI in a batch job):

    ```bash
    gmsh -3 geometry.geo
    ```

3. Convert the mesh to elmer's format using ElmerGrid, including scaling if needed:

    ```bash
    ElmerGrid 14 2 geometry.msh -scale 0.001 0.001 0.001
    ```

4. Create a new project in ElmerGUI (can be done on **viz**):
   - create project  
   - load Elmer mesh (point to the created mesh directory)
   - add equation(s)  
   - add material(s)  
   - add boundary conditions  
   - create sif
   - edit & save sif

5. Edit the `case.sif` file (mesh directory, some other parameters [e.g. calculate PrincipalStresses] can only be added in the sif file, not in the GUI).

6. Run simulation:

    ```bash
    srun ElmerSolver 
    ```

    or create batch file and submit using sbatch.

7. Postprocessing in ParaView.
