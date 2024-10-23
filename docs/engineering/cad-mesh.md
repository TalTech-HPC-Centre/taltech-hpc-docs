
# CAD & Mesh-Tools

CAD and meshing software installed on **viz**, **amp** and **green** cluster nodes.

<br> 
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## FreeCAD

---

FreeCAD is an easy to use open-source CAD software, that can use Gmsh or Netgen for meshing. It can also serve as a frontend for CalculiX and [ElmerFEM](/engineering/elmerfem.md), thus providing similar functionality as SolidWorks. 

    module load rocky8
    module load freecad
    freecad

(Please don't run simulations on **viz**) FreeCAD is best used  within a [VNC session](../visualization/vnc.md).


### How to cite:

FreeCAD available from: [https://www.freecadweb.org](https://www.freecadweb.org).


<br> 
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Salome

---

Salome is a multi-platform environment, allowing the realization of physics simulations. Salome is suitable for various stages of a study: from creation of the CAD model and the mesh to the post-processing and visualization of the results. Other functionalities such as uncertainty treatment, data assimilation are also implemented. Salome does not contain a physics solver but it provides the computing environment necessary for their integration.

    module load rocky8
    module load salome/9.13.0

Salome has a python interface, so the meshing can be done as a batch-job on the cluster nodes.

The current state can be dumped into a script from the GUI by `CTRL+D`, the script can then be executed on the command-line by: 

	salome -t scriptname.py

It is therefore possible to prepare the geometry on your workstation or an OnDemand desktop session, dump the script, add the meshing command and run the script on the cluster in batch-mode.


See separate page on [visualization](../visualization.md).


### How to cite:

Salome can be cited as [DOI:10.13140/RG.2.2.12107.08485](https://www.researchgate.net/publication/318531878_SALOME_an_Open-Source_simulation_platform_integrating_ParaView?channel=doi&linkId=596f5f25458515d5ff64e0c6&showFulltext=true).

<br> 
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## BRL-CAD

---

[BRL-CAD](https://brlcad.org/) is a CAD software that has been in development since 1979 and is open-source since 2004. It is based on CSG modeling. BRL-CAD does not provide volume meshing, however, the CSG geometry can be exported to BREP (boundary representation, like STL, OBJ, STEP, IGES, PLY), the `g-*` tols are for this, while the `*-g` tools are for importing. An introduction can be found [in this PDF](https://brlcad.org/w/images/9/90/Intro_to_BRL-CAD.pdf).


<br> 
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Gmsh

---

Gmsh meshes can be used with [ElmerFEM](/engineering/elmerfem.md) and [OpenFOAM](/engineering/openfoam.md). For OpenFOAM, make sure it is saved as version 2 and ASCII format. 

The GUI can be used within a OnDemand desktop session, large meshes can be done as batch jobs on cluster nodes (use srun or sbatch), on the command-line run:

    gmsh -3 -format msh2 -o outfilename.msh infilename.geo

this creates a volume mesh and saves as version 2 format suitable for OpenFOAM.

Use the SPACK module:

    module load rocky8-spack
    module load gmsh


### How to cite:

If you use Gmsh please cite [C. Geuzaine and J.-F. Remacle. Gmsh: a three-dimensional finite element mesh generator with built-in pre- and post-processing facilities. Int. J. Numer. Methods Eng., 79(11), pp. 1309-1331, 2009](https://gmsh.info/doc/preprints/gmsh_paper_preprint.pdf). 
You can also cite additional [references](https://gmsh.info/#References) for specific features and algorithms.


<br> 
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Netgen (NGsolve)

---

[Netgen](https://ngsolve.org/) is a part of the NGsolve suite. Netgen is a  automatic 3d tetrahedral mesh generator containing modules for mesh optimization and hierarchical mesh refinement. It accepts input from constructive solid geometry `.csg` or boundary representation (BRep) from `.stl` files, but also handles `.brep`, `.step` and `.iges` formats. Those meshes generated can be exported in several formats (e.g. neutral, Abaqus, Fluent, [ElmerFEM](/engineering/elmerfem.md) Gmsh and [OpenFOAM](/engineering/openfoam.md)). Netgen has a GUI (e.g. use a [X2GO](../visualization/x2go.md) session on **viz**), but can also be used through its Python interface.

A Python example using the OpenCASCADE kernel:

    from netgen.NgOCC import *
    geo = LoadOCCGeometry('screw.step')
    geo.Heal()
    mesh = geo.GenerateMesh()
    # mesh.Save('screw.vol')
    mesh.Export("export.msh","Gmsh Format")
    
    from ngsolve import *
    Draw(Mesh(mesh))


A Python example using the netgen STL:

     import netgen.stl as stl
     geo2 = stl.LoadSTLGeometry("input.stl")
     m2 = geo2.GenerateMesh (maxh=0.05)
     m2.Export("export.msh","Gmsh2 Format")


You can get a list of export formats from the GUI.

### How to cite:

Netgen - [J. Schöberl. NETGEN An advancing front 2D/3D-mesh generator based on abstract rules. Comput. Vis. Sci., 1(1):41–52, 1997](https://link.springer.com/article/10.1007/s007910050004).

Netgen/NGSolve is open source and available at [www.ngsolve.org](www.ngsolve.org).

<br> 
<br> 
