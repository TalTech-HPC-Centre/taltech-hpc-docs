# CREST

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## CREST short introduction 

---

1. Make [crest.slurm](crest.slurm) batch script for parallel calculations:
           
	   #!/bin/bash
	   #SBATCH --job-name=CREST-test
	   #SBATCH --mem-per-cpu=2GB
	   #SBATCH --nodes=1
	   #SBATCH --ntasks=1
	   #SBATCH --cpus-per-task=24
	   #SBATCH -t 1-00:00:00
	   #SBATCH --partition=common

	   module load rocky8/all
       module load xtb-crest
  
       #Run calculations 
       crest geometry.xyz --gfn2 --T 24 > final.out

2. Copy job-input file [geometry.xyz](geometry.xyz)
3. Submit the job on **base**:

	   sbatch crest.slurm

***NB!*** CREST can be run only on 1 node. If job requires large memory amount, **bigmem** or **gpu** partition with 1TB RAM can be used. 

***NB!*** It is recommended to optimize the geometries obtained from the CREST by more accurate methods. In the [end of this page](https://docs.hpc.taltech.ee/chemistry/crest.html#useful-bash-scripts) are given home-made bash scripts that can be helpful during this process. 

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## CREST long version 

---

CREST (Conformer–Rotamer Ensemble Sampling Tool) was designed as conformer sampling program by Grimme's group. Conformational search can be done by various levels of theory including molecular mechanics and semiempirical methods (GFNn-xTB) in gas or solvent (using several continuum models). By default CREST uses root-mean-square-deviation (RMSD) based meta-dynamics, short regular MD simulations and Genetic Z-matrix crossing (GC) algorithms for generation of new conformers. CREST can be also used for searching of protonation states, tautomerism studies and non-covalent complexes modelling. More can be found in the [original article](https://pubs.rsc.org/en/content/articlelanding/2020/CP/C9CP06869D#!divCitation).

### Environment

Environment is set up by the commands:

    module load rocky8/all
    module load xtb-crest

### Running CREST jobs

CREST input file should be in `.xyz` format and is executed by the command `crest`. This command is usually placed in `slurm` script. 

    crest geometry.xyz --gfn2 --gbsa h2o --T 24 > final.out

In CREST calculation options are specified as command line arguments. `--T` is number of processors used, `--gfn2` -- calculation method (_here GFN2-xTB_), `--g h2o` -- GBSA implicit solvation model for water. More about [command line arguments](https://crest-lab.github.io/crest-docs/page/documentation/keywords.html) and some [examples](https://crest-lab.github.io/crest-docs/page/examples) of CREST commands.

### Time

Calculation time depends on size of molecule, its flexibility, chosen energy window, methods used, and can only be determined empirically. For example, for a flexible organic molecule of 65 atoms, conformational search using GFN-FF method and 24 cores took about 15-20 minutes and semiempirical GFN2 needed 5-8 hours. However, a lot depend on energy window applied to conformational search.

### Memory

Our experience shows that memory is the main limiting factor in conformational search calculations by CREST. Since memory consumption depends on many factors (size of molecule, its flexibility, chosen energy window, methods used), it can only be determined through trial and error, and perhaps **mem1tb** or **gpu** partition with 1TB RAM can be used. 
In our test runs for a flexible organic molecule of 54 atoms using semiempirical GFN2 method, 1 GB per core was sufficient, but for 65 atoms molecule using the same level of theory already 2 GB per core were needed.


### How to cite:

The main publication for the CREST program - DOI: [10.1039/C9CP06869D](https://doi.org/10.1039/C9CP06869D).

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Useful bash scripts

---

It is recommended to optimise the geometries obtained from the CREST by more accurate methods. Here are home-made bash scripts that can be helpful. 

- [Start-orca.sh](start-orca.sh) & [start-gaussian.sh](start-gaussian.sh)

    [Start-orca.sh](start-orca.sh) should be run from the directory where CREST conformer search was done. It splits CREST output into single geometries, prepare ORCA inputs and launch calculations.  
    ***NB!*** [orca.slurm](orca.slurm) must be in the same folder as `start-orca.sh` and CREST calculations.  
    ***NB!*** Charge, Multiplisity and Number of conformers must be given as  command line arguments `-c`, `-m` and `-n`.
  
        sh start-orca.sh -c 0 -m 1 -n 500
 
    By default ORCA calculations will be done using the following method - ***RI-BP86-BJD3/def2-SVP*** . If it does not suit, the method can be changed in the `start-orca.sh` in the section "ORCA method".
 
    [Start-gaussian.sh](start-gaussian.sh) by analogy with `start-orca.sh` will create input for Gaussian and launch calculations.  

    By default Gaussian calculations will be done using the following method - ***BP86-BJD3/def2-SVP SMD(chloroform, Surface=SAS, Radii=Bondi)*** . If it does not suit, the method can be changed in the `start-gaussian.sh` in the section "Gaussian method".

    ***NB!*** if Surface=SAS & Radii=Bondi are not used just replace them by one space and remove `read` from `scrf` keywords.  
    ***NB!*** [gaussian.slurm](gaussian.slurm) must be in the same folder as `start-gaussian.sh` and CREST calculations.  
    ***NB!*** Charge, Multiplisity and Number of conformers must be given as  command line arguments `-c`, `-m` and `-n`.

- [Check.sh](check.sh) verifies if all calculations ended normally.

   ***NB!*** If Gaussian calculations were done - activate disabled rows starting with `#` and disable above rows for ORCA search by adding `#` mark before them.

- [Crest-sorting.sh](crest-sorting.sh) available only for ORCA calculations.    
                1. creates CREST folder and move the initial CREST calculations there  
                2. merges individual ORCA optimised geometries into a shared file `ALL.xyz`  
                3. creates a single CREST file, which then will be treated by CREST algorithms to delete double structures and sort remained structures by energy.

                
