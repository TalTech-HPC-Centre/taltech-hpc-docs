# Multiwfn

!!! warning
    This page is a work in progress!

## Multiwfn Short Introduction

---

1. Make Multiwfn input `.mwfn`, `.wfn`, `.wfx`, `.fch`, `.molden`, `.gms` (or `.cub`, `.grd`, `.pdb`, `.xyz`, `.mol` - for specific purposes).

2. Access **viz** by [remote access programs](/visualization/visualization) (more preferable) or by SSH protocol (less preferable):

    ```sh
    ssh -X -Y -J UNI-ID@base.hpc.taltech.ee UNI-ID@viz
    ```

3. Load environment:

    ```sh
    module use /gpfs/mariana/modules/green/chemistry/
    module load MultiWFN/3.7
    ```

4. Run Multiwfn in interactive mode:

    ```sh
    srun Multiwfn job.wfn
    ```

    Multiwfn can also be run by [multiwfn.slurm](/software/attachments/multiwfn.slurm) batch script in non-interactive mode with pre-prepared responses:

    ```sh
    #!/bin/bash
    #SBATCH --nodes=1
    #SBATCH --ntasks=1
    #SBATCH --job-name=test
    #SBATCH --mem=2GB
    #SBATCH -t 1:00
    #SBATCH --partition=short

    module load green/all
    module load MultiWFN/3.7 

    Multiwfn job.wfn << EOF > /dev/null
    2
    2
    -4
    6
    0
    -10
    100
    2
    1
    mol.pdb
    q
    EOF
    ```

    In this case, the job is submitted using the `sbatch` command:

    ```sh
    sbatch multiwfn.slurm
    ```

5. Visualize results if needed:

    ```sh
    display job.png
    ```

    or

    ```sh
    module use /gpfs/mariana/modules/gray/spack/
    module load vmd
    vmd job.pdb
    ```

    **NB!** It is recommended to visualize Multiwfn results in the VMD program. Corresponding scripts are provided in Multiwfn examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)_.

---

## Multiwfn Long Version

---

### Options

Multiwfn is an interactive program performing almost all important wavefunction analyses _(showing molecular structure and orbitals, calculating real space function, topology analysis, population analysis, orbital composition analysis, bond order/strength analysis, plotting population density-of-states, plotting various kinds of spectra (including conformational weighted spectrum), quantitative analysis of molecular surface, charge decomposition analysis, basin analysis, electron excitation analyses, orbital localization analysis, visual study of weak interaction, conceptual density functional theory (CDFT) analysis, energy decomposition analysis)_.

For many frequently used analyses, Multiwfn has [short YouTube videos](https://www.youtube.com/user/sobereva) and "quick start" examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)._ More information can be found in the [manual](/software/attachments/Manual_Multiwfn.pdf).

### Input

As input, Multiwfn uses output files of other quantum chemistry programs, including Gaussian, ORCA, GAMESS-US, NWChem, xtb, Turbomole. For example, `.wfn` (wavefunction file), `.fch` (Gaussian check file), `.molden` (Molden input file), `.gms` (GAMESS-US output file), `.mwfn` (Multiwfn wavefunction file). Other types of files, such as `.cub`, `.grd`, `.pdb`, `.xyz`, `.log`, `.out`, and `.mol` files, may be used in certain cases and purposes.

### Environment

On **viz**, the environment is set up by the commands:

```sh
module use /gpfs/mariana/modules/green/chemistry/
module load MultiWFN/3.7
```

For the first-time use, the user has to agree to the licenses:

```sh
touch ~/.licenses/multiwfn-accepted
```

If this is the first user license agreement, the following commands should be given:

```sh
mkdir .licenses
touch ~/.licenses/multiwfn-accepted
```

**NB!** After agreeing to the license, the user has to log out and log in again to be able to run `Multiwfn`.

On **base**, the environment is set up by the commands:

```sh
module load rocky8/all
module load MultiWFN/3.7
```

The user also needs to agree with the licenses, as described above.

### Running Multiwfn

**NB!**
Since Multiwfn has a lot of functionality, we recommend that the user first study the corresponding section in the manuals ([text](/software/attachments/Manual_Multiwfn.pdf), [video](https://www.youtube.com/user/sobereva)) or examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)._ This will greatly simplify the selection of answers in the interactive menu.

The best practice is to try to reproduce something from the examples folder. To do this, the corresponding files will need to be copied to the user's directory using the following commands:

```sh
mkdir examples
cp -r /gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/* examples/
```

**NB!** The user can run Multiwfn only from their own folder, not from the shared one.

For visualization that does not perform additional calculations but only reads outputs (for example, spectra visualization), Multiwfn can be run in interactive mode using `srun`:

```sh
srun Multiwfn job.log
```

or using several threads (here - 4):

```sh
srun -n 4 Multiwfn job.log
```

To exit interactive mode, press the `q` key.

For jobs connected to electron density analysis, especially in large systems, it is recommended to run the [multiwfn.slurm](/software/attachments/multiwfn.slurm) batch script with pre-prepared responses. Below is a slurm script for Critical Points (CPs) search using job.wfn:

```sh
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=test
#SBATCH --mem=2GB
#SBATCH -t 1:00
#SBATCH --partition=short

module load rocky8/all
module load MultiWFN/3.7

Multiwfn job.wfn << EOF > /dev/null
2
2
-4
6
0
-10
100
2
1
mol.pdb
q
EOF
```

The job is submitted by the `sbatch` command:

```sh
sbatch multiwfn.slurm
```

### Results Visualization

By default, plots made by Multiwfn will be written in the `.png` format and can be visualized by the command:

```sh
display job.png
```

Although Multiwfn has its own graphical interface, we recommend visualizing Multiwfn results in the VMD (Visual Molecular Dynamics) program. Corresponding scripts are provided in Multiwfn examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)_ (with `.vmd` extensions). More about visualization on **viz** can be found [here](/visualization/visualization) and about VMD - [here](/visualization/visualization-chemistry#vmd).

On **base**, the VMD environment is set up by the commands:

```sh
module load green
module load VMD
```

VMD is run by the command `vmd`:

```sh
vmd job.pdb
```

### How to Cite

**Citing the original paper of Multiwfn is mandatory** - DOI: [10.1002/jcc.22885](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.22885)

**In addition, the following articles should be cited depending on the analyses performed:**

- Quantitative molecular surface analysis (main function 12) - DOI: [10.1016/j.jmgm.2012.07.004](https://www.sciencedirect.com/science/article/abs/pii/S1093326312000903)
- Hole-electron analysis (subfunction 1 of main function 18) - DOI: [10.1016/j.carbon.2020.05.023](https://www.sciencedirect.com/science/article/abs/pii/S0008622320304644)
- Electrostatic potential evaluation algorithm - DOI: [10.1039/D1CP02805G](https://pubs.rsc.org/en/content/articlelanding/2021/cp/d1cp02805g)
- Orbital composition analysis (main function 8) - _Tian Lu, Feiwu Chen, Calculation of Molecular Orbital Composition, Acta Chim. Sinica, 69, 2393-2406 (2011)_ (in Chinese) ([http://sioc-journal.cn/Jwk_hxxb/CN/abstract/abstract340458.shtml](http://sioc-journal.cn/Jwk_hxxb/CN/abstract/abstract340458.shtml))
- Charge decomposition analysis (CDA) (main function 16) - _Meng Xiao, Tian Lu, Generalized Charge Decomposition Analysis (GCDA) Method, Journal of Advances in Physical Chemistry, 4, 111-124 (2015)_ (in Chinese) ([http://dx.doi.org/10.12677/JAPC.2015.44013](http://dx.doi.org/10.12677/JAPC.2015.44013))
- Atomic dipole moment corrected Hirshfeld (ADCH) - DOI: [10.1142/S0219633612500113](https://www.worldscientific.com/doi/10.1142/S0219633612500113)
- Population analysis module (main function 7) - DOI: [10.3866/PKU.WHXB2012281](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB2012281)
- Laplacian bond order (LBO) - DOI: [10.1021/jp4010345](https://pubs.acs.org/doi/10.1021/jp4010345)
- Statistical analysis of area in different ESP ranges on vdW surface - DOI: [10.1007/s11224-014-0430-6](https://pubs.acs.org/doi/10.1021/jp4010345)
- Charge-transfer spectrum - DOI: [10.1016/j.carbon.2021.11.005](https://www.sciencedirect.com/science/article/abs/pii/S0008622321010745?via%3Dihub)
- Electron localization function (ELF) - DOI: [10.3866/PKU.WHXB20112786](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB20112786)
- Analysis of valence electron and deformation density - DOI: [10.3866/PKU.WHXB201709252](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB201709252)
- Predicting binding energy of hydrogen bonds based properties of bond critical point - DOI: [10.1002/jcc.26068](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.26068)
- Electron analysis based on localized molecular orbitals (e.g. subfunction 22 of main function 100) - DOI: [10.1007/s00214-019-2541-z](https://link.springer.com/article/10.1007/s00214-019-2541-z)
- Van der Waals potential analysis (subfunction 6 of main function 20) - DOI: [10.1007/s00894-020-04577-0](https://pubmed.ncbi.nlm.nih.gov/33098007/)
- Interaction region indicator (IRI) (subfunction 4 of main function 20) - DOI: [10.1002/cmtd.202100007](https://chemistry-europe.onlinelibrary.wiley.com/doi/10.1002/cmtd.202100007)
- Independent gradient model based on Hirshfeld partition (IGMH) (subfunction 11 of main function 20) - DOI: [10.1002/jcc.26812](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.26812)
- ICSSZZ map (subfunction 4 in main function 200) - DOI: [10.1016/j.carbon.2020.04.099](https://www.sciencedirect.com/science/article/abs/pii/S000862232030436X)
- MO-PDOS map (Option -2 in main function 10) - DOI: [10.1016/j.carbon.2020.05.023](https://www.sciencedirect.com/science/article/abs/pii/S0008622320304644)
- Molecular polarity index (MPI) (outputted by main function 12) - DOI: [10.1016/j.carbon.2020.09.048](https://www.sciencedirect.com/science/article/abs/pii/S0008622320309076)
- Analysis of valence electron and deformation density - DOI: [10.3866/PKU.WHXB201709252](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB201709252)
- Studying molecular planarity via MPP, SDP and coloring atoms according to ds values - DOI: [10.1007/s00894-021-04884-0](https://pubmed.ncbi.nlm.nih.gov/34435265/)
- Energy decomposition analysis based on force field (EDA-FF) - DOI: [10.1016/j.mseb.2021.115425](https://www.sciencedirect.com/science/article/abs/pii/S0921510721003834)
