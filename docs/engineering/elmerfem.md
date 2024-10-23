
# ElmerFEM

**This page is work in progress**

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## ElmerFEM 

---

Elmer is a multi-physics simulation software developed by CSC. It can perform coupled mechanical, thermal, fluid, electro-magnetic simulations and can be extended by own equations.

<div class="simple1">
Some useful links:

 - Elmer homepage: [http://www.elmerfem.org/blog/](http://www.elmerfem.org/blog/)
 - Elmer manuals and tutorials: [https://www.nic.funet.fi/pub/sci/physics/elmer/doc/](https://www.nic.funet.fi/pub/sci/physics/elmer/doc/)
</div>
<br>

### How to cite:

_CSC – IT CENTER FOR SCIENCE LTD., 2020. Elmer, Available at: https://www.csc.fi/web/elmer/._

<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Loading the module

---

To use ElmerFEM the module needs to be loaded

	module load rocky8-spack    
	module load elmerfem/9.0-gcc-10.3.0-netlib-lapack-qjdi

This makes the following main commands `ElmerGrid`, `ElmerSolver` available and `ElmerGUI` can be used with X11 forwarding or in an OnDemand desktop session to setup the case file. The use of ElmerGUI to run simulations is **not** recommended.

<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Running a tutorial case (quick-start for the impatient)

---

1. Copy the tutorial directory (here the linear elastic beam) and go into it:

	    cp -r /share/apps/HPC2/ElmerFEM/tutorials-CL-files/ElasticEigenValues/ linear-elastic-beam-tutorial
    	cd linear-elastic-beam-tutorial

2. Start an interactive session on a node

	    srun -t 2:00:00 --pty bash

3. Create the mesh

	    ElmerGrid d 7 2 mesh.FDNEUT

4. Run the solver

	    ElmerSolver

5. Postprocessing would be visualizing the `eigen_values.vtu` file in `paraview`.

<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Setting up a simulation (for new users)

---


The follwing steps are needed to configure a simulation case (mostly on **base**).   

1. Create geometry in Gmsh, group and name physical volumes and surfaces (can be done on **viz).**    

2. Create mesh in Gmsh (large meshes can be created from the CLI in a batch job: 
	
		gmsh -3 geometry.geo

3. Convert the mesh to elmer's format using ElmerGrid, including scaling if needed: 

		ElmerGrid 14 2 geometry.msh -scale 0.001 0.001 0.001

4. <div class="simple1"> Create a new project in ElmerGUI (can be done on <b>viz</b>). 

    - create project  
    - load Elmer mesh (point to the created mesh directory)   
    - add equation(s)  
    - add material(s)  
    - add boundary conditions  
    - create sif   
    - edit & save sif </div>   

5. Edit the `case.sif` file (mesh directory, some other parameters [e.g. calculate PrincipalStresses] can only be added in the sif file, not in the GUI)

6. Run simulation: 

		srun ElmerSolver 
	or create batch file and submit using sbatch.

7. Postprocessing in ParaView.

<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## An example simulation case from start to finish

---


