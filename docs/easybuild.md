<span style="color:red">not changed to rocky yet</span>

# EasyBuild

**under development, docs AND module positions/versions may change without notice**

EasyBuild is a package manager to install software packages. An advantage is to be able to relatively easily install consistent dependencies and multiple versions of a software. [List of packages](https://docs.easybuild.io/en/latest/version-specific/Supported_software.html)

## Modules

EasyBuild is available on **amp** from AI lab

    module use /illukas/software/modules




## User build software

EasyBuild can also be used by users to manage their own software stack inside their home directory (be aware, this takes a lot of space!).

See documentation on [https://docs.easybuild.io/en/latest/](https://docs.easybuild.io/en/latest/)

A similar tool is SPACK. They support different lists of software packages. SPACK includes GPU-offloading compiler for both Nvidia and AMD, profiling tools (Tau, HPCToolkit) and engineering simulation packages (ElmerFEM, OpenFOAM), while EasyBuild seems to be more AI and Python oriented

EasyBuild will be used on LUMI, while SPACK is used by University of Tartu, LRZ and HLRS.
