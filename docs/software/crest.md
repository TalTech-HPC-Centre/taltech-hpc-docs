# CREST

## CREST Short Introduction

---

1. Create the [crest.slurm](/software/attachments/crest.slurm) batch script for parallel calculations:

    ```bash
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

    # Run calculations 
    crest geometry.xyz --gfn2 --T 24 > final.out
    ```

2. Copy the job input file [geometry.xyz](/software/attachments/geometry.xyz).
3. Submit the job on **base**:

    ```bash
    sbatch crest.slurm
    ```

**NB!** CREST can be run only on 1 node. If the job requires a large amount of memory, the **mem1tb** partition with 1TB RAM can be used.

**NB!** It is recommended to optimize the geometries obtained from CREST by more accurate methods. At the [end of this page](#useful-bash-scripts), home-made bash scripts are provided that can be helpful during this process.

---

## CREST Long Version

CREST (Conformer–Rotamer Ensemble Sampling Tool) was designed as a conformer sampling program by Grimme's group. Conformational search can be done at various levels of theory, including molecular mechanics and semiempirical methods (GFNn-xTB) in gas or solvent (using several continuum models). By default, CREST uses root-mean-square-deviation (RMSD) based meta-dynamics, short regular MD simulations, and Genetic Z-matrix crossing (GC) algorithms for the generation of new conformers. CREST can also be used for searching protonation states, tautomerism studies, and non-covalent complex modeling. More information can be found in the [original article](https://pubs.rsc.org/en/content/articlelanding/2020/CP/C9CP06869D#!divCitation).

### Environment

The environment is set up with the commands:

```bash
module load rocky8/all
module load xtb-crest
```

### Running CREST Jobs

The CREST input file should be in `.xyz` format and is executed with the command `crest`. This command is usually placed in a `slurm` script.

```bash
crest geometry.xyz --gfn2 --gbsa h2o --T 24 > final.out
```

In CREST calculations, options are specified as command line arguments. `--T` is the number of processors used, `--gfn2` is the calculation method (_here GFN2-xTB_), and `--g h2o` is the GBSA implicit solvation model for water. More about [command line arguments](https://crest-lab.github.io/crest-docs/page/documentation/keywords.html) and some [examples](https://crest-lab.github.io/crest-docs/page/examples) of CREST commands.

### Time

Calculation time depends on the size of the molecule, its flexibility, the chosen energy window, and the methods used, and can only be determined empirically. For example, for a flexible organic molecule of 65 atoms, a conformational search using the GFN-FF method and 24 cores took about 15-20 minutes, while the semiempirical GFN2 method needed 5-8 hours. However, a lot depends on the energy window applied to the conformational search.

### Memory

Our experience shows that memory is the main limiting factor in conformational search calculations by CREST. Since memory consumption depends on many factors (size of the molecule, its flexibility, the chosen energy window, methods used), it can only be determined through trial and error. Perhaps the **mem1tb** partition with 1TB RAM can be used. 
In our test runs for a flexible organic molecule of 54 atoms using the semiempirical GFN2 method, 1 GB per core was sufficient, but for a 65-atom molecule using the same level of theory, 2 GB per core were needed.

### How to Cite

The main publication for the CREST program - DOI: [10.1039/C9CP06869D](https://doi.org/10.1039/C9CP06869D).

---

## Useful Bash Scripts

---

It is recommended to optimize the geometries obtained from CREST by more accurate methods. Here are home-made bash scripts that can be helpful.

- [Start-orca.sh](/software/attachments/start-orca.sh) & [start-gaussian.sh](/software/attachments/start-gaussian.sh)

    [Start-orca.sh](/software/attachments/start-orca.sh) should be run from the directory where the CREST conformer search was done. It splits the CREST output into single geometries, prepares ORCA inputs, and launches calculations.  
    **NB!** [orca.slurm](/software/attachments/orca.slurm) must be in the same folder as `start-orca.sh` and CREST calculations.  
    **NB!** Charge, multiplicity, and number of conformers must be given as command line arguments `-c`, `-m`, and `-n`.
  
    ```bash
    sh start-orca.sh -c 0 -m 1 -n 500
    ```

    By default, ORCA calculations will be done using the following method - **RI-BP86-BJD3/def2-SVP**. If it does not suit, the method can be changed in the `start-orca.sh` in the section "ORCA method".

    [Start-gaussian.sh](/software/attachments/start-gaussian.sh) by analogy with `start-orca.sh` will create input for Gaussian and launch calculations.  

    By default, Gaussian calculations will be done using the following method - **BP86-BJD3/def2-SVP SMD(chloroform, Surface=SAS, Radii=Bondi)**. If it does not suit, the method can be changed in the `start-gaussian.sh` in the section "Gaussian method".

    **NB!** If Surface=SAS & Radii=Bondi are not used, just replace them with one space and remove `read` from `scrf` keywords.  
    **NB!** [gaussian.slurm](/software/attachments/gaussian.slurm) must be in the same folder as `start-gaussian.sh` and CREST calculations.  
    **NB!** Charge, multiplicity, and number of conformers must be given as command line arguments `-c`, `-m`, and `-n`.

- [Check.sh](/software/attachments/check.sh) verifies if all calculations ended normally.

   **NB!** If Gaussian calculations were done, activate disabled rows starting with `#` and disable the above rows for the ORCA search by adding the `#` mark before them.

- [Crest-sorting.sh](/software/attachments/crest-sorting.sh) available only for ORCA calculations.
    1. Creates a CREST folder and moves the initial CREST calculations there.  
    2. Merges individual ORCA optimized geometries into a shared file `ALL.xyz`.  
    3. Creates a single CREST file, which will then be treated by CREST algorithms to delete duplicate structures and sort the remaining structures by energy.

