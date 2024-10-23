# Multiwfn

***This manual is work in progress, please check regularly for updates***

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Multiwfn short introduction 

---

1. Make Multiwfn input `.mwfn`, `.wfn`, `.wfx`, `.fch`, `.molden`, `.gms` (or `.cub`, `.grd`, `.pdb`, `.xyz`, `.mol` - for specific purposes).

2. Accesse **viz** by [remote access programs](../visualization.md) (more preferable) or by ssh protocol (less preferable):
 
        ssh -X -Y -J  UNI-ID@base.hpc.taltech.ee UNI-ID@viz

3. Load enviroment:

        module use /gpfs/mariana/modules/green/chemistry/
        module load MultiWFN/3.7

4. Run Multiwfn in interactive mode:

        srun Multiwfn job.wfn
        
    Multiwfn also can be run by [multiwfn.slurm](multiwfn.slurm) batch script as a non-interactive mode with pre-prepared responses:

        #!/bin/bash
        #SBATCH --nodes=1
        #SBATCH --ntasks=1
        #SBATCH --job-name=test
        #SBATCH --mem=2GB
        #SBATCH -t 1:00
        #SBATCH --partition=short

        module load green/all
        module load MultiWFN/3.7 

        Multiwfn  job.wfn << EOF > /dev/null
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
        
        
    In this case job is submitted using `sbatch` command:
    
        sbatch multiwfn.slurm
        
   
5. Visualize results if needed:
    
        display job.png

    or 
    
        module use /gpfs/mariana/modules/gray/spack/
        module load vmd
        vmd job.pdb
                
    ***NB!*** It is recommended to visualize Multiwfn results in VMD program, corresponding scripts are provided in Multiwfn examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)_.

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Multiwfn long version 

---

### Options

Multiwfn is an interactive program performing almost all of important wavefunction analyszes _(showing molecular structure and orbitals, calculating real space function, topology analysis, population analysis, orbital composition analysis, bond order/strength analysis, plotting population density-of-states, plotting various kinds of spectra (including conformational weighted spectrum), quantitative analysis of molecular surface, charge decomposition analysis, basin analysis, electron excitation analyses, orbital localization analysis, visual study of weak interaction, conceptual density functional theory (CDFT) analysis, energy decomposition analysis)._

For many frequently used analyszes Multiwfn has [short youtube videos](https://www.youtube.com/user/sobereva) and "quick start" examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)._ More information can be found in the [manual](Manual_Multiwfn.pdf). 


### Input

As an input Multiwfn uses output files of other quantum chemistry programs, including Gaussian, ORCA, GAMESS-US, NWChem, xtb, Turbomole. For example, `.wfn` (wavefunction file), `.fch` (Gaussian check file), `.molden` (Molden input file), `.gms` (GAMESS-US output file), `.mwfn` (Multiwfn wavefunction file). Other types of files, such as  such as `.cub`, `.grd`, `.pdb`, `.xyz`, `.log`, `.out`  and `.mol` files, may be used in certain cases and purposes.

### Environment

On **viz** environment is set up by the commands:

    module use /gpfs/mariana/modules/green/chemistry/
    module load MultiWFN/3.7 

The first time use, user has to agree to the licenses: 
        
    touch ~/.licenses/multiwfn-accepted 

if this is the first user license agreement, the following commands should be given:

    mkdir .licenses
    touch ~/.licenses/multiwfn-accepted 

***NB!*** After agreeing to the license, user has to log out and log in again to be able run `Multiwfn`.  
        
On **base** environment is set up by the commands:

    module load rocky8/all
    module load MultiWFN/3.7 
        
User also needs to agree with the licenses, as described above.
        
### Running Multiwfn 

***NB!*** 
Since Multiwfn has a lot of functionality, we recommend that the user first study the corresponding section in the manuals ([text](Manual_Multiwfn.pdf), [video](https://www.youtube.com/user/sobereva)) or examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)._ This will greatly simplify the selection of answers in the interactive menu.

The best practice is to try to reproduce something from the examples folder. To do this, the corresponding files will need to be copied to the user's derictory using the following commands:

    mkdir examples
    cp -r /gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/* examples/

***NB!*** The user can run Multiwfn only from his own folder, not from the shared.
    
For visualization that does not perform additional calculations, but only reads outputs (for example spectra visualization), Multiwfn can be run in interactive mode using `srun`:

    srun Multiwfn job.log
    
or using several threads (here - 4):    
    
    srun -n 4 Multiwfn job.log

To exit interactive mode press `q` key. 

For jobs connected to electron density analysis especially in large systems it is recommended to run [multiwfn.slurm](multiwfn.slurm) batch script with pre-prepared responses. Below is shown slurm script for Critical Points (CPs) search using job.wfn:

    #!/bin/bash
    #SBATCH --nodes=1
    #SBATCH --ntasks=1
    #SBATCH --job-name=test
    #SBATCH --mem=2GB
    #SBATCH -t 1:00
    #SBATCH --partition=short

    module load rocky8/all
    module load MultiWFN/3.7 

    Multiwfn  job.wfn << EOF > /dev/null
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

Job is submitted by `sbatch` command:
    
    sbatch multiwfn.slurm   


### Results visualization

By default, plots made by Multiwfn will be written in the `.png` format and can be visualized by command:

    display job.png
        
Although Multiwfn has its own graphical interface, we recommend to visualize Multiwfn results in VMD (Visual Molecular Dynamics) program, corresponding scripts are provided in Multiwfn  examples _(/gpfs/mariana/software/green/MultiWFN/Multiwfn_3.7_bin_Linux/examples/)_ (with `.vmd` extensions). More about visualization on **viz** can be found [here](../visualization.md) and about VMD - [here](https://docs.hpc.taltech.ee/chemistry/visualization.html#vmd).

On **base** VMD environment is set up by the commands:

    module load green
    module load VMD 

VMD is run by command `vmd`:

    vmd job.pdb
            

#### How to cite:

**Citing the original paper of Multiwfn is mandatory** - DOI: [10.1002/jcc.22885](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.22885)

<div class="simple1">
<b>In addition, the following articles should be cited depending on the analyzes performed:</b>

- Quantitative molecular surface analysis (main function 12) - DOI:[10.1016/j.jmgm.2012.07.004](https://www.sciencedirect.com/science/article/abs/pii/S1093326312000903)
- Hole-electron analysis (subfunction 1 of main function 18) - DOI:[10.1016/j.carbon.2020.05.023](https://www.sciencedirect.com/science/article/abs/pii/S0008622320304644)
- Electrostatic potential evaluation algorithm - DOI:[10.1039/D1CP02805G](https://pubs.rsc.org/en/content/articlelanding/2021/cp/d1cp02805g)
- Orbital composition analysis (main function 8). - _Tian Lu, Feiwu Chen, Calculation of Molecular Orbital Composition, Acta Chim. Sinica, 69, 2393-2406 (2011)_ (in Chinese) ([http://sioc-journal.cn/Jwk_hxxb/CN/abstract/abstract340458.shtml](http://sioc-journal.cn/Jwk_hxxb/CN/abstract/abstract340458.shtml))
- Charge decomposition analysis (CDA) (main function 16) - _Meng Xiao, Tian Lu, Generalized Charge Decomposition Analysis (GCDA) Method,
Journal of Advances in Physical Chemistry, 4, 111-124 (2015)_ (in Chinese) ([http://dx.doi.org/10.12677/JAPC.2015.44013](http://dx.doi.org/10.12677/JAPC.2015.44013))
- Atomic dipole moment corrected Hirshfeld (ADCH) - DOI:[10.1142/S0219633612500113](https://www.worldscientific.com/doi/10.1142/S0219633612500113)
- Population analysis module (main function 7) - DOI:[10.3866/PKU.WHXB2012281](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB2012281)
- Laplacian bond order (LBO) - DOI: [10.1021/jp4010345](https://pubs.acs.org/doi/10.1021/jp4010345)
- Statistical analysis of area in different ESP ranges on vdW surface - DOI:[10.1007/s11224-014-0430-6](https://pubs.acs.org/doi/10.1021/jp4010345)
- Charge-transfer spectrum  - DOI:[10.1016/j.carbon.2021.11.005](https://www.sciencedirect.com/science/article/abs/pii/S0008622321010745?via%3Dihub)
- Electron localization function (ELF) - DOI:[10.3866/PKU.WHXB20112786](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB20112786)
- Analysis of valence electron and deformation density - DOI:[10.3866/PKU.WHXB201709252](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB201709252)
- Predicting binding energy of hydrogen bonds based properties of bond critical point - DOI:[10.1002/jcc.26068](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.26068)
- electron analysis based on localized molecular orbitals (e.g. subfunction 22 of main function 100) - DOI:[10.1007/s00214-019-2541-z](https://link.springer.com/article/10.1007/s00214-019-2541-z)
- van der Waals potential analysis (subfunction 6 of main function 20) - DOI:[10.1007/s00894-020-04577-0](https://pubmed.ncbi.nlm.nih.gov/33098007/)
- Interaction region indicator (IRI) (subfunction 4 of main function 20) - DOI:[10.1002/cmtd.202100007](https://chemistry-europe.onlinelibrary.wiley.com/doi/10.1002/cmtd.202100007)
- Independent gradient model based on Hirshfeld partition (IGMH) (subfunction 11 of main function 20) - DOI:[10.1002/jcc.26812](https://onlinelibrary.wiley.com/doi/abs/10.1002/jcc.26812)
- ICSSZZ map (subfunction 4 in main function 200) - DOI:[10.1016/j.carbon.2020.04.099](https://www.sciencedirect.com/science/article/abs/pii/S000862232030436X)
- MO-PDOS map (Option -2 in main function 10) - DOI:[10.1016/j.carbon.2020.05.023](https://www.sciencedirect.com/science/article/abs/pii/S0008622320304644)
- Molecular polarity index (MPI) (outputted by main function 12) - DOI:[10.1016/j.carbon.2020.09.048](https://www.sciencedirect.com/science/article/abs/pii/S0008622320309076)
- Analysis of valence electron and deformation density - DOI:[10.3866/PKU.WHXB201709252](http://www.whxb.pku.edu.cn/EN/10.3866/PKU.WHXB201709252)
- Studying molecular planarity via MPP, SDP and coloring atoms according to ds values - DOI:[10.1007/s00894-021-04884-0](https://pubmed.ncbi.nlm.nih.gov/34435265/)
- Energy decomposition analysis based on force field (EDA-FF) - DOI:[10.1016/j.mseb.2021.115425](https://www.sciencedirect.com/science/article/abs/pii/S0921510721003834)
</div>
<br>
 
 
 
 
