# EasyBuild

!!! warning
    This page has not been completely updated for Rocky 8 yet!
    This page is a work in progress!

EasyBuild is a package manager used to install software packages. An advantage is the ability to relatively easily install consistent dependencies and multiple versions of software. [List of packages](https://docs.easybuild.io/en/latest/version-specific/Supported_software.html)

## Modules

EasyBuild is available on **amp** from the AI lab.

```bash
module use /illukas/software/modules
```

## User-built software

EasyBuild can also be used by users to manage their own software stack inside their home directory (be aware, this takes a lot of space!).

See EasyBuild documentation [here](https://docs.easybuild.io/en/latest/).

A similar tool is SPACK. They support different lists of software packages. SPACK includes GPU-offloading compilers for both Nvidia and AMD, profiling tools (Tau, HPCToolkit), and engineering simulation packages (ElmerFEM, OpenFOAM), while EasyBuild seems to be more AI and Python-oriented.

EasyBuild will be used on LUMI, while SPACK is used by the University of Tartu, LRZ, and HLRS.
