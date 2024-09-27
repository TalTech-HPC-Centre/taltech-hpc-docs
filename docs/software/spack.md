# SPACK

!!! warning
    This page has not been completely updated for Rocky 8 yet!
    This page is a work in progress!

---

SPACK is a package manager used to install software packages. An advantage is the ability to relatively easily install consistent dependencies and multiple versions of software. The following link contains a list of software that should be easy to install: [SPACK package list](https://packages.spack.io/)

## Modules

SPACK makes use of the module system. To enable SPACK build modules, use:

For gray and **all** nodes (optimized for Xeon E5-2630L Haswell CPUs, will also run on green nodes but will not use all hardware features):

```
module load gray-spack
```

Optimized for **green** nodes (optimized for Xeon Gold 6148 Skylake CPUs, may not run on gray nodes):

```
module load green-spack
```

Optimized for **amp** (AMD EPYC 7742 Zen2), available only on amp:

```
module load amp-spack
```

By default, SPACK builds are optimized for the CPU the software is built on.
The packages from the gray nodes will work on the green nodes but slower than the optimized modules. Conversely, the Skylake-optimized modules will try to use hardware features not present on the gray nodes, so the software will not run there.

You can auto-activate the correct module path in your `.bashrc` with a code block like this:

```bash
if [[ $(hostname -s) = base ]]; then
  module load green-spack
elif [[ $(hostname -s) = green* ]]; then
  module load green-spack
elif  [[ $(hostname -s) = gray* ]]; then
  module load gray-spack
elif  [[ $(hostname -s) = amp ]]; then
  module load amp-spack
fi
```

## User-built software

SPACK can also be used by users to manage their own software stack inside their home directory (be aware, this takes a lot of space!).

See documentation on <https://spack.readthedocs.io/en/latest/>

A similar tool is [EasyBuild](https://docs.easybuild.io/en/latest/). They support different lists of software packages. SPACK includes GPU-offloading compilers for both Nvidia and AMD, profiling tools (Tau, HPCToolkit), and engineering simulation packages (ElmerFEM, OpenFOAM), while EasyBuild seems to be more AI and Python-oriented <https://docs.easybuild.io/en/latest/version-specific/Supported_software.html>.

SPACK is used by the University of Tartu, LRZ, and HLRS, while EasyBuild will be used on LUMI.
