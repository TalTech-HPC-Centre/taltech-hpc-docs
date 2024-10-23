<span style="color:red">not changed to rocky yet</span>

# Octave/Matlab

Octave is a free alternative to Matlab and if you do not use Matlab's toolboxes, your code should work without many changes. For many of Matlab's toolboxes (partial) implementations exist for Octave as well.
we have setup a module for Octave:

    module load octave
    

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Octave: Example of a non-interactive batch job (single process)

---

SLURM batch script `octave-script.slurm`

    #!/bin/bash
    #SBATCH --partition=common
    #SBATCH -t 2:10:00
    #SBATCH -J octave
    module load octave
    octave script.m

The commands that Octave should calculate are in `script.m`

    n = 1000; 
    A = normrnd(0,1, n, n); 
    X = A'*A; Y = inv(X); 
    a = mean( diag(Y*X) ); 
    ## should output 1.0: 
    a


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Octave netcdf toolbox

---

To use netcdf in octave the toolbox octcdf has to be installed from octave forge. Note that octcdf is a NetCDF toolbox for Octave which aims to be compatible with the „original“ matlab toolbox.

To install the toolbox do following steps in the frontend and later the package is available in all nodes for your user.

    module load green-spack
    module load octave
    octave

Inside octave do:

    pkg install -forge -verbose octcdf

You may need to scroll down when necessary and it should complete the compilation successfully. Then you can start using Octcdf in your octave scripts by adding the line

    pkg load octcdf


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Matlab

---

Matlab is available on the cluster through a campus license. Use

    module avail

to see which version is installed. If a newer is needed, contact us via hpcsupport.
Start using it by loading the module

    module load green
    module load Matlab/R2018a

Matlab can be used non-interactive (like Octave in the above example).

