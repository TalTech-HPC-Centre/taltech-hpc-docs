# NWChem

***This manual is work in progress, please check regularly for updates***

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## NWChem short introduction 

---

1. Make [nwchem.slurm](nwchem.slurm) batch script for parallel calculations:

        #!/bin/bash

        #SBATCH --job-name=NWChem
        #SBATCH --mem-per-cpu=2GB
        #SBATCH --nodes=1
        #SBATCH --ntasks=6
        #SBATCH -t 1:00:00
        #SBATCH --partition=common

        module load rocky8-spack
        module load nwchem

        #Create scratch directory
        SCRATCH=/state/partition1/$SLURM_JOB_ID
        mkdir -p $SCRATCH
        cp  $SLURM_SUBMIT_DIR/*.nw $SCRATCH/
        cd $SCRATCH/

        nwchem  job.nw >> job.out

        #Copy files back to working directory
        cp $SCRATCH/* $SLURM_SUBMIT_DIR

        #Clean after yourself
        rm -rf  $SCRATCH

2. Copy job-input file [job.nw](job.nw).

3. Submit the job on **base**:

        sbatch nwchem.slurm

4. Check results using [visualization software](visualization.md).

<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## NWChem long version 

---

The North West computational chemistry ([NWChem](https://nwchemgit.github.io/)) is an ab initio computational chemistry software package. NWChem offers various approaches: density functional (DFT), second-order Möller–Plesset perturbation theory (MP2), single- and multi-reference (MR), ground-and excited-state and linear-response (LR) coupled-cluster (CC), multi-configuration self-consistent field (MCSCF), selected and full configuration interaction (CI). A broad range of DFT response properties, ground and excited-state molecular dynamics (MD) using either AMBER or CHARMM force fields or methods of quantum mechanics (QM), nudged elastic band (NEB) method, linear-response (LR), and real-time (RT) time-dependent density functional theory (TDDFT) are available in NWChem. Through its modular design, the ab initio methods can be coupled with the classical MD to perform mixed quantum-mechanics and molecular-mechanics simulations (QM/MM). Various solvent models and relativistic approaches are also available. Additionally, python programs may be embedded into the NWChem input and used to control the execution of NWChem. More about the possibilities of NWChem can be found in this article - [10.1063/5.0004997](https://aip.scitation.org/doi/10.1063/5.0004997).

<div class="simple1">
Some useful links:

- the tutorials site at FAccTs - [https://nwchemgit.github.io/Home.html](https://nwchemgit.github.io/Home.html)
- DOI:[10.1016/j.cpc.2010.04.018](https://www.sciencedirect.com/science/article/abs/pii/S0010465510001438?via%3Dihub)
</div>
<br>

### Environment

At HPC is installed 7.0.2 version of NWChem. To start working with NWChem an environment needed to be set up with the commands:

    module load rocky8-spack
    module load nwche

### Input file

<div class="simple1">
NWChem input file consists from certain blocks: geometry, SCF, DFT, MP2, etc. NWChem also allows to combine several jobs into one input file. Bellow is given example of NWChem input file (job.nw) where: 

1. water dimer will bi firstly optimized at BP86-D3BJ/def2-SVP level of theory
2. frequency calculations will be done at the same level of theort
3. single poin energy will be calculated using larger basis set (def2-TZVPP) and B3LYP functional.
</div>

Additionally in example input file are shown inplementation of some useful keywords as `print` and `linopt`.

    start water            # all intermediate files will have this name
    title "Water dimer"    # title of job

    echo                   # input file will be printed in the beginning of the output file

    memory total 3000 mb

    charge 0
    
    geometry units angstrom
    O    -0.093470    -1.154274     0.290542
    H     0.329461    -0.566865    -0.340362
    H    -0.864449    -1.335840    -0.238173
    O    -0.135461     1.136660    -0.233474
    H     0.636237     1.304331     0.298468
    H    -0.563123     0.545569     0.390712
    end

    basis
        * library Def2-SVP
    end

    scf
        rhf                    # restricted Hartree-Fock
        singlet                # multiplicity
        maxiter 100            # maximum number of SCF iterations 
        print low              # will minimize output
    end

    dft
        mult 1                 # multiplicity
        xc becke88 perdew86    # functional BP86
        disp vdw 4             # dispersion correction D3BJ
        print low              # will minimize output
    end

    driver
        maxiter 100            # maximum number of iterations during optimization
        linopt 0               # speed up calculations 
    end

    task dft optimize
    task dft freq numerical

    basis
        * library Def2-TZVPP
    end

    dft
        mult 1                 # multiplicity
        xc b3lyp               # functional B3LYP
        disp vdw 4             # dispersion correction D3BJ
        print low              # will minimize output
    end

    task dft energy

    
NWChem is well suited for large system calculations or molecular dynamics simulations with subsequent calculation of system properties. Example of an input ([job_MD.nw](job_MD.nw)) for MD sinumation with subsequent calculation of dipole moment every 10 steps.   
    
More about NWChem input can be found at [NWChem manual](https://nwchemgit.github.io/Home.html).

### Running NWChem jobs

NWChem input files are executed by the command `nwchem`. This command is usually placed in slurm script.

### Single core & parallel calculations

NWChem jobs can be calculated on one thread, in parallel on one node or using several nodes at once. Depending on the size of job, the corresponging parameters must be modified in slurm file:
        
    #SBATCH --ntasks=6
    #SBATCH --nodes=1

Below is given an example of `slurm` script for NWChem parallel run on 1 node and 6 threads with allocated memory of 3 GB:

    #!/bin/bash

    #SBATCH --job-name=NWChem
    #SBATCH --mem=3GB
    #SBATCH --nodes=1
    #SBATCH --ntasks=6
    #SBATCH -t 1:00:00
    #SBATCH --partition=common

    module load rocky8-spack
    module load nwchem

    #Create scratch directory
    SCRATCH=/state/partition1/$SLURM_JOB_ID
    mkdir -p $SCRATCH
    cp  $SLURM_SUBMIT_DIR/*.nw $SCRATCH/
    cd $SCRATCH/

    nwchem  job.nw > job.out

    #Copy files back to working directory
    cp $SCRATCH/* $SLURM_SUBMIT_DIR

    #Clean after yourself
    rm -rf  $SCRATCH


***NB!*** _in example of `slurm` script calculations will be done on a single node, thus partition is `common`. If several nodes will be use than partition should be `green-ib`._

    #SBATCH --nodes=2
    #SBATCH --ntasks=120
    #SBATCH --partition=green-ib

***NB!*** _to be able to restart calculations, they must be done in the `$HOME` catalog, and not in `$SCRATCH` directory._

    
### Restarting a failed/interrupted calculation

NWChem does not give message about normal ternination. If calculation terminated normally, otput will have this end:

                                      AUTHORS
                                      -------
     E. Apra, E. J. Bylaska, N. Govind, K. Kowalski, M. Valiev, W. A. de Jong,
      T. P. Straatsma, H. J. J. van Dam, D. Wang, T. L. Windus, N. P. Bauman,
       A. Panyala, J. Hammond, J. Autschbach, K. Bhaskaran-Nair, J. Brabec,
    K. Lopata, S. A. Fischer, S. Krishnamoorthy, M. Jacquelin, W. Ma, M. Klemm,
       O. Villa, Y. Chen, V. Anisimov, F. Aquino, S. Hirata, M. T. Hackler,
           Eric Hermes, L. Jensen, J. E. Moore, J. C. Becca, V. Konjkov,
            D. Mejia-Rodriguez, T. Risthaus, M. Malagoli, A. Marenich,
    A. Otero-de-la-Roza, J. Mullin, P. Nichols, R. Peverati, J. Pittner, Y. Zhao,
        P.-D. Fan, A. Fonari, M. J. Williamson, R. J. Harrison, J. R. Rehr,
      M. Dupuis, D. Silverstein, D. M. A. Smith, J. Nieplocha, V. Tipparaju,
      M. Krishnan, B. E. Van Kuiken, A. Vazquez-Mayagoitia, M. Swart, Q. Wu,
    T. Van Voorhis, A. A. Auer, M. Nooijen, L. D. Crosby, E. Brown, G. Cisneros,
     G. I. Fann, H. Fruchtl, J. Garza, K. Hirao, R. A. Kendall, J. A. Nichols,
       K. Tsemekhman, K. Wolinski, J. Anchell, D. E. Bernholdt, P. Borowski,
       T. Clark, D. Clerc, H. Dachsel, M. J. O. Deegan, K. Dyall, D. Elwood,
      E. Glendening, M. Gutowski, A. C. Hess, J. Jaffe, B. G. Johnson, J. Ju,
        R. Kobayashi, R. Kutteh, Z. Lin, R. Littlefield, X. Long, B. Meng,
      T. Nakajima, S. Niu, L. Pollack, M. Rosing, K. Glaesemann, G. Sandrone,
      M. Stave, H. Taylor, G. Thomas, J. H. van Lenthe, A. T. Wong, Z. Zhang.

    Total times  cpu:       56.9s     wall:       57.2s

If job was not terminated normally, it can be restarted. However, to do this, calculations must be done in the `$HOME` catalog, and not in `$SCRATCH` directory.

To restart calculation just change `start` command to `restart` in initial input file and run slurm script again. 

***NB!*** _we recommend to change the restart output file name so it was possible to compare progress in the end of calculations._

### Memory

At the beginning of the NWChem input file the amount of memory requested for the entire job must be specified. If amount of memory requested is insufficient, the job can crash. Memory usage in NWChem is controlled by the `memory total` keywords.

    memory total 3000 mb

There is no golden rule for memory requests, since they are  basis set and calculation type dependant. Usually, 1-5 GB per 1 CPU is sufficient. Data from a `slurm-JOBID.stat` file can be useful to determine the amount of memory required for a computation. In `slurm-JOBID.stat` file the efficiency of memory utilization is shown. 

Bad example:

    Memory Utilized: 3.08 GB 
    Memory Efficiency: 11.83% of 26.00 GB

Good example:

    Memory Utilized: 63.12 GB 
    Memory Efficiency: 98.62% of 64.00 GB
    
### Time

Time limits depend on time partition used, see [taltech user-guides](https://docs.hpc.taltech.ee/index.html#hardware-specification). If the calculation time exceeds the time limit requested in the `slurm` script, then the job will be killed. Therefore, it is recommended to request more time than is usually needed for calculation. 

### How to cite:


Please cite DOI:[10.1063/5.0004997](https://aip.scitation.org/doi/10.1063/5.0004997) when publishing results obtained with NWChem: 

And also look at the [NWChem manual](https://nwchemgit.github.io/Home.html) on the relevant topic, more detailed information on citing will be given there. 
<br>
<br>




