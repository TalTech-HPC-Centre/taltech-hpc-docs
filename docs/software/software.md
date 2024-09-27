# Software packages

Software on our systems is installed in the following ways:

1. as packages from the Linux distribution (free open-source software when available and recent enough) -- **no modules needed**
2. through the SPACK package manager (free open-source software when available in SPACK) - load the `*-spack` modules by command:

    ```bash
    module load rocky8-spack
    ```

3. manually (mostly non-free software (not GPL/BSD license)) - load the `*/all` modules by command:

```bash
module load rocky8/all
```

Here is a list of important software for special purpose:

- CAD & Meshing software - FreeCAD, Salome, BRL-CAD, Gmsh and netgen; see [CAD-Mesh](/software/cad-mesh)
- Finite element software for multiphysical problems - [ElmerFEM](/software/elmerfem), CalculiX, Abaqus
- Computational Fluid Dynamics -- [OpenFOAM](/software/openfoam), SU2
- Conformational search  - [xtb-CREST](/software/crest)
- General purpose computational chemistry, biology and physics software packages - [Gaussian](/software/gaussian), [ORCA](/software/orca), [NWChem](/software/nwchem), [TURBOMOLE](/software/turbomole), xTB, CP2K
- Wavefunction analysis - [Multiwfn](/software/multiwfn)
- Visualization software for computational chemistry, biology and physics - [Molden](/visualization/visualization-chemistry#molden), [Avogadro](/visualization/visualization-chemistry#avogadro), [JMol](/visualization/visualization-chemistry#jmol), [VMD](/visualization/visualization-chemistry#vmd), [RasMol](/visualization/visualization-chemistry#rasmol)
- Interactive and non-interactive [Jupyter](/software/jupyter) notebooks for Julia, Python, [Octave](/software/octave)
- Matlab-compatible computation environment - [Octave](/software/octave)
- Data analysis - R, Matlab, [Octave](/software/octave), Julia, awk, Python, GNUplot
- Visualization software - MayaVi2, ParaView, VisIt, COVISE, OpenDX, GNUplot

A more detailed description of available softwares, as well as a division by area of use, is given below.

If software you want to use is missing in the list above, it means that it is not installed, but can be installed by your request to [hpcsupport@taltech.ee](mailto:hpcsupport@taltech.ee) or create a ticket in [Helpdesk Portal](https://helpdesk.taltech.ee/login.jsp). In the case of licensed software, the user must provide the license himself and the corresponding program will be installed.

---

## Engineering

### CAD & Mesh-Tools

Computer-aided design (CAD) is software for building models in a virtual space, that allows to visualize various properties of an object, such as height, width, distance, material, etc. This category contains software that is essential for the pre-processing of many simulations: CAD and mesh generation.
More about CAD and meshing options on our HPC can be found [here](/software/cad-mesh).

#### FreeCAD

[FreeCAD](https://www.freecadweb.org/features.php) is a CAD software, which uses [Gmsh](/software/cad-mesh#gmsh) or [Netgen](/software/cad-mesh#netgen-ngsolve) for meshing. It can also serve as a frontend for CalculiX and [ElmerFEM](/software/elmerfem), thus providing similar functionality as SolidWorks. More about FreeCAD on our HPC can be found [here](/software/cad-mesh).

#### Salome

[Salome](https://salome-platform.org/) is a CAD program with interfaces to meshing software. It can be used by a GUI or python scripts. More about Salome on our HPC can be found [here](/software/cad-mesh#salome).

#### BRL-CAD

[BRL-CAD](https://brlcad.org/) is a CAD software that has been in development since 1979 and is open-source since 2004. It is based on CSG modeling. BRL-CAD does not provide volume meshing, however, the CSG geometry can be exported to BREP (boundary representation, like STL, OBJ, STEP, IGES, PLY), the `g-*` tools are for this, while the `*-g` tools are for importing. More about BRL-CAD on our HPC can be found [here](/software/cad-mesh#brl-cad).

#### Blender

[Blender](https://blender.org) is a 3D modeling software developed for computer animation (movie production).

#### Gmsh

[Gmsh](https://gmsh.info/) is an open source 3D finite element mesh generator with a built-in CAD engine and post-processor. More about Gmsh on our HPC can be found [here](/software/cad-mesh#gmsh).

#### Netgen

[Netgen](https://ngsolve.org/) is a part of the NGsolve suite. Netgen is an automatic 3d tetrahedral mesh generator containing modules for mesh optimization and hierarchical mesh refinement. More about Netgen on our HPC can be found [here](/software/cad-mesh#netgen-ngsolve).

### Finite Element Analysis (FEA)

The Finite Element Method (FEM) is a general numerical method for solving partial differential equations in two or three space variables performed by dividing a large system into smaller parts (finite elements). The method is used for numerically solving differential equations in engineering and mathematical modeling.

See also under [computational-fluid-dynamics-CFD](#computational-fluid-dynamics-cfd).

#### ElmerFEM

[Elmer](http://www.elmerfem.org/blog/) is a multi-physics simulation software developed by CSC. It can perform coupled mechanical, thermal, fluid, electro-magnetic simulations and can be extended by own equations. Elmer manuals and tutorials can be found [here](https://www.nic.funet.fi/pub/sci/physics/elmer/doc) and for more details and example job scripts go [here](/software/elmerfem).

#### CalculiX

CalculiX is a finite-element analysis application. The two programs that form CalculiX are `cgx` and `ccx`, where `cgx` is a graphical frontend (pre- and post-processing) and `ccx` is the solver doing the actual numerics.
CalculiX can be used for grid data generation or mech data generation. It can be applied in such areas as mechanical analysis, heat transfer, electromagnetic calculations, computational fluid dynamics, etc. For more details see [overview](http://www.dhondt.de/ov_calcu.htm) of the finite element capabilities of CalculiX Version 2.18.
Solver makes use of the Abaqus input format.

#### FreeFEM

[FreeFEM](https://freefem.org/) is a software focused on solving partial differential equations using the finite element method. Can be used for linear, non-linear elasticity, thermal diffusion/convection/radiation, magnetostatics, electrostatics, CFD, fluid structure interaction; continuous and discontinuous Galerkin method.
Allows to implement own physics modules using the FreeFEM language.

#### deal.II

[deal.II](https://www.dealii.org/) - an open source finite element library

#### MFEM

[MFEM](https://mfem.org/) is a free, lightweight, scalable C++ library for finite element methods.

#### Abaqus

Abaqus is a commercial software suite for finite element analysis and computer-aided engineering. The Abaqus products use Python for scripting and customization. User modules can be written in Fortran or C/C++, our installation is configured to use gcc-10.3.0. Abaqus versions 2018 and 2021 are installed. The number of concurrent processes is limited and managed by flexlm.

```bash
module load rocky8
module load abaqus
```

To use Abaqus' PlatformMPI, SLURM's Global Task ID needs to be cleared

```bash
unset SLURM_GTIDS
```

#### Comsol

Commercial multi-physics finite element simulation software. License belongs to a research group.

#### LSDyna

License belongs to a research group.

```bash
module load rocky8
module load LSDyna/SMP-13.0.0-D
```

#### Star-CCM+

Commercial software. System wide installation, _bring your own license_.
Star-CCM+ can be used with PowerOnDemand (PoD) keys. Power on demand (PoD) licensing for STAR-CCM+ is essentially cloud licensing. To use PoD licensing, a PoD key must be copied from the Star-CCM+ support center and put into the STAR-CCM+ interface.

More information about licenses:

- [Simcenter STAR-CCM+ demand](https://www.dex.siemens.com/plm/simcenter-on-the-cloud/simcenter-star-ccm-power-on-demand)
- [How faculty members in academic institutions can get access to Simcenter STAR-CCM+](https://community.sw.siemens.com/s/article/How-faculty-members-in-academic-institutions-can-get-access-to-Simcenter-STAR-CCM)
- [Guide for students to run Simcenter STAR-CCM+](https://blogs.sw.siemens.com/simcenter/guide-for-students-to-run-simcenter-star-ccm-from-home-or-elsewhere/)

```bash
module load rocky8
module load star-ccm+/18.04.009-R8
starccm+
```

### Computational Fluid Dynamics (CFD)

See also under [FEA](#finite-element-analysis-fea).

#### OpenFOAM

[OpenFOAM](https://openfoam.org/) is an open source software for computational fluid dynamics (CFD). OpenFOAM has a wide range of tools for modelling complex fluid flows and can be used for solving such problems as chemical reactions, turbulence and heat transfer, to acoustics, solid mechanics and electromagnetics. More about OpenFOAM on our HPC can be found [here](/software/openfoam).

#### SU2

[SU2](https://su2code.github.io/) is a computational analysis and design package that has been developed to solve multiphysics analysis and optimization tasks using unstructured mesh topologies. SU2 is installed through SPACK.

### Water Wave Modelling

#### WAM

[WAM](https://github.com/mywave/WAM) is a third generation wave model, developed and maintained by GKSS. It describes the evolution of the wave spectrum by solving the wave energy transfer equation. WAM predicts directional spectra and wave properties (such as wave height, direction and frequency, swell height and mean direction), wind stress fields etc. WAM can be coupled to a range of other models (NEMO, RegCM, SEAOM, etc.). More info how to use it on HPC see [here](/software/wam).

#### Swan

[SWAN](https://www.tudelft.nl/citg/over-faculteit/afdelingen/hydraulic-engineering/sections/environmental-fluid-mechanics/research/swan) is a third generation wave model for obtaining realistic estimates of wave parameters in coastal areas, lakes and estuaries from given wind, bottom and current conditions, developed and maintained by TU Delft. The model is based on the wave action balance equation with sources and sinks. SWAN allows to use two types of grids (structured and unstructured) and nesting approach. More info how to use it on HPC see [here](/software/swan).

---

## Chemistry, biology and physics

### Conformational search & sampling

#### xtb-CREST

Conformer–Rotamer Ensemble Sampling Tool [(xtb-CREST)](https://xtb-docs.readthedocs.io/en/latest/crest.html) is designed as conformer sampling program by Grimme's group. CREST uses meta-dynamics, regular MD simulations and Genetic Z-matrix crossing (GC) algorithms with molecular mechanics or semiempirical methods (GFNn-xTB). Conformational search can be done in gas or solvent (using several continuum models). More about xtb-CREST on our HPC can be found [here](/software/crest).

### General purpose computational chemistry, biology and physics

#### Gaussian

[Gaussian](https://gaussian.com/g16main/) is a general purpose package for calculation of electronic structures. It can calculate properties of molecules (structures, energies, spectroscopic and thermochemical properties, atomic charges, electron affinities and ionization potentials, electrostatic potentials and electron densities etc.) and reactions properties (such as reaction pathways, IRC) using different methods (such as Molecular mechanics, Semi-empirical methods, Hartree-Fock, Density functional, Møller-Plesset perturbation theory, coupled cluster). More about Gaussian on HPC can be found [here](/software/gaussian).

#### ORCA

[ORCA](https://orcaforum.kofo.mpg.de/app.php/portal) is a multi-purpose quantum-chemical software package developed in the research group of Frank Neese. ORCA includes a wide variety of methods (semi-empirical, density functional theory, many-body perturbation, coupled cluster, multireference, nudged elastic band (NEB) methods). In ORCA, molecules' and spectroscopic properties calculations are available, and environmental (MD (including ab initio), QM/MM, Crystal-QMMM) as well as relativistic effects can be taken into account. ORCA is parallelized, and uses the resolution of the identity (RI) approximation and domain based local pair natural orbital (DLPNO) methods, which significantly speed calculations. More about ORCA on HPC can be found [here](/software/orca)

#### xtb

[Extended tight binding - xTB](https://xtb-docs.readthedocs.io/en/latest) program developed in the research group of Stefan Grimme for solutions of common chemical problems. The workhorses of xTB are the GFN methods, both semi-empirical and force-field. The program contains several implicit solvent models: GBSA, ALPB, ddCOSMO, and CPCM-X. xTB functionality covers single-point energy calculations, geometry optimization, frequency calculations, reaction path methods. Also allows to perform molecular dynamics, meta-dynamics, and ONIOM calculations. More about xTB on HPC can be found [here](/software/xtb)

#### NWChem

The North West computational chemistry ([NWChem](https://nwchemgit.github.io/)) is an ab initio computational chemistry software package which includes quantum chemical (HF, DFT, MP2, MCSCF, and CC, including the tensor contraction engine (TCE)) and molecular dynamics (using either force fields (AMBER or CHARMM) or DFT) functionality. In NWChem, ab initio methods can be coupled with the classical MD to perform mixed quantum-mechanics and molecular-mechanics simulations (QM/MM). Various molecular response properties, solvent models, nudged elastic band (NEB) method, relativistic and resolution of the identity (RI) approaches are also available.

NWChem was developed to enable large scale calculations by using many CPUs and has parallel scalability and performance. Additionally, python programs may be embedded into the NWChem input and used to control the execution of NWChem.

### Wavefunction analysis

#### Multiwfn

[Multiwfn](http://sobereva.com/multiwfn/) it is an interactive program that performs almost all important wavefunction analyzes. In addition, Multiwfn is able to display plots of the predicted spectra. More about Multiwfn on HPC can be found [here](/software/multiwfn).

### Visualization software for computational chemistry, biology and physics

- [Molden](/visualization/visualization-chemistry#molden)
- [Avogadro](/visualization/visualization-chemistry#avogadro)
- [JMol](/visualization/visualization-chemistry#jmol)
- [VMD](/visualization/visualization-chemistry#vmd)
- [RasMol](/visualization/visualization-chemistry#rasmol)

---

## Data analysis

### GNU R

[GNU R](https://www.r-project.org/), often called "GNU S" is an open-source implementation of the S statistics language. R offers many build-in features for data analysis, has a large collection of well maintained packages in CRAN (the Comprehensive R Archive Network) and most importantly produces high-quality graphics. While the plots may not look fancy at first sight, they are well layed out with font sizes and they are vector graphics. Another feature is that R integrates well with LaTeX2e documents using Sweave (comes with R) or knitr. That makes it possible to write the data analysis using R code within LaTeX2e documents and have R create figures and tables automatically.

CRAN Packages can be installed by the users themselves from inside R

```bash
install.packages("packagename",lib=paste(Sys.getenv("HOME"),"/.R/library",sep=""),repos="http://cran.r-project.org")
```

The package will be placed inside the user's $HOME directory (installation into system directories will not be allowed).

### Julia

[Julia](https://julialang.org/) is an easy to learn and high-performance interactive language. Julia is as easy (or easier) to learn as Python, but with the speed of C or Fortran for numerics.

### Octave/Matlab

[Octave](https://octave.sourceforge.io/) is software featuring a high-level programming language, intended for prototyping numerical computations. Octave solves linear and nonlinear problems, and for performing other numerical experiments using a language that is mostly compatible with MATLAB. It may also be used as a batch-oriented language. More information about Matlab and Octave on HPC can be found [here](/software/octave).

### GNUplot

[GNUplot](http://www.gnuplot.info/) is a very capable and portable command-line driven graphing utility for Linux and other operating systems.

### Python

Different versions are available as spack modules.
Packages for Python can be installed by the users themselves using pip (python2) or pip3 (python3)

```bash
pip install --user packagename
```

or

```bash
pip3 install --user packagename
```

The option `--user` will install the package into the user's $HOME directory (installation into system directories will not be allowed).

### JupyterLab

[JupyterLab](https://jupyter.org/) notebook is an open-source web application that allows creation and sharing documents containing live code, equations, visualizations, and text. Jupyter notebooks allow data transformation, numerical simulation, statistical modeling, data visualization, machine learning, etc. using Julia, Python and Octave. More about Jupyter on our HPC is [here](/software/jupyter).

---

## Visualization software

- [ParaView](https://www.paraview.org/) (**all nodes** spack module paraview)
- [VisIt](https://visit-dav.github.io/visit-website/) (**all nodes** spack module visit)
- [COVISE](https://www.hlrs.de/solutions/types-of-computing/visualization/covise) (**viz**: run `/usr/local/covise/bin/covise`)
- [MayaVi](http://mayavi.sourceforge.net/) (**all nodes:** spack module py-mayavi)
- GNUplot  (**all nodes** )
- [OpenDX](http://www.opendx.org/) (**currently not available** will come soon)
- Software for computational chemistry:
  - [Molden](https://www.theochem.ru.nl/molden/)
  - [Avogadro](https://avogadro.cc/)
  - [JMol](http://jmol.sourceforge.net/)
  - [VMD](http://www.ks.uiuc.edu/Research/vmd/)(**all nodes:** spack module vmd)
  - [RasMol](http://www.openrasmol.org/)
- Software for movie animation
  - Blender

The recommended way is now to use a desktop session in OnDemand, see also the [visualization](/visualization/visualization) page on how to start these and on GPU acceleration.
