# Octave/Matlab

!!! warning
    This page has not been completely updated for Rocky 8 yet!

Octave is a free alternative to Matlab and if you do not use Matlab's toolboxes, your code should work without many changes. For many of Matlab's toolboxes (partial) implementations exist for Octave as well. We have setup a module for Octave:

```bash
module load octave
```

## Octave: Example of a non-interactive batch job (single process)

SLURM batch script `octave-script.slurm`

```bash
#!/bin/bash
#SBATCH --partition=common
#SBATCH -t 2:10:00
#SBATCH -J octave
module load octave
octave script.m
```

The commands that Octave should calculate are in `script.m`

```octave
n = 1000; 
A = normrnd(0,1, n, n); 
X = A'*A; Y = inv(X); 
a = mean( diag(Y*X) ); 
## should output 1.0: 
a
```

---

## Octave netcdf toolbox

To use netcdf in Octave, the toolbox octcdf has to be installed from Octave Forge. Note that octcdf is a NetCDF toolbox for Octave which aims to be compatible with the "original" Matlab toolbox.

To install the toolbox, do the following steps in the frontend and later the package is available in all nodes for your user.

```bash
module load green-spack
module load octave
octave
```

Inside Octave, do:

```octave
pkg install -forge -verbose octcdf
```

You may need to scroll down when necessary and it should complete the compilation successfully. Then you can start using Octcdf in your Octave scripts by adding the line

```octave
pkg load octcdf
```

---

## Matlab

Matlab is available on the cluster through a campus license. Use

```bash
module avail
```

to see which version is installed. If a newer version is needed, contact us via hpcsupport. Start using it by loading the module

```bash
module load green
module load Matlab/R2018a
```

Matlab can be used non-interactively (like Octave in the above example).
