# LUMI Software

LUMI offers a wide range of programs in different fields:

- Machine learning on top of PyTorch and TensorFlow
- Image classification - ResNet
- Object recognition and XFMR translation - SSD, XFMR
- Scientific software suites - Gromacs (molecular dynamics), CP2K (quantum chemistry), and ICON (climate science)
- Weather prediction application - GridTools allowing measures stencil-based
- etcetera

More information about installed software and how to install software yourself can be found in the [LUMI documentation](https://docs.lumi-supercomputer.eu/software/).

The list of available programs can be found in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/). There you can also find license information - whether the program is free to use, requires pre-registration, or the user must provide their own license.

## First time use

To be able to use a program, the user first has to install it. Installation can be done by **SPACK** or by **EasyBuild**. The list of available programs in **EasyBuild** can be found in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) as well as installation instructions. The list of programs that can be installed by **SPACK** can be viewed by the `spack list` command. The same program can be installed by both **SPACK** and **EasyBuild**.

There are two possible places where programs can be installed - the user's `$HOME` or project directory. The latter is recommended since other users of the project will be able to use installed programs as well. Moreover, `$HOME` size is limited to 20GB. More about [data storage at LUMI](https://docs.lumi-supercomputer.eu/storage/#where-to-store-data) and [storage billing](https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/#storage-billing).

The project `XXX` number can be found in [ETAIS](https://etais.ee) as `Effective ID`.

![Project Number](/access/attachments/projectN.png)

It is good practice to add the place where programs will be installed into your `.profile` or `.bashrc` file. To do this, give the command:

```sh
echo "export EBU_USER_PREFIX=/project/project_XXX" >> .bashrc
```

where `XXX` is a project number.

To install programs, use the following commands:

```sh
export EASYBUILD_PREFIX=$HOME/easybuild 
export EASYBUILD_BUILDPATH=/tmp/$USER
```

## Program installation

### Installation by SPACK

1. Initialize **SPACK**:

    ```sh
    export SPACK_USER_PREFIX=/project/project_XXX/spack 
    module list
    ```

    where the project `XXX` number can be found in [ETAIS](https://etais.ee) as `Effective ID`.

    After, the user should load the following modules:

    ```sh
    module load LUMI/YYY partition/ZZZ 
    module load spack/RRR
    ```

    where `YYY` is the version of LUMI, which will appear in the module list.  
    Partition `ZZZ` is determined depending on whether CPUs (partition/C) or GPUs (partition/G) will be used.  
    `RRR` is the version of **SPACK**, which will appear in the module list.

    ![list-spack](/access/attachments/list-spack.png)

2. The entire list of programs available for installation by **SPACK** can be viewed by the command:

    ```sh
    spack list
    ```

    The list will be too long, so it is better to search for a certain program by the command:

    ```sh
    spack list program_name
    ```

    where the whole name or part of it is given.

    **NB!** **SPACK** is insensitive to caps.

3. Check what flags should be added:

    ```sh
    spack info program_name
    ```

    ![spack](/access/attachments/spack.png)

4. Program installation is done by the command:

    ```sh
    spack install program_name@version%compiler@version +flag(s) ^forced_dependencies
    ```

    where `flag` is an installation option taken from variants of **SPACK** info (see above). It is recommended to try the `cce` (Cray Compiler Edition) and for MPI-dependent software to force the `cray-mpich` dependency.

    For example:

    ```sh
    spack install nwchem@7.0.2%cce@15.0.1 +openmp ^cray-mpich@8.1.25
    ```

    or

    ```sh
    spack install kokkos+rocm+debug_bounds_check amdgpu_target=gfx90a %gcc@11.2.0
    ```

    Refresh the module list:

    ```sh
    spack module tcl refresh -y
    ```

    For more details, see the [LUMI guide](https://docs.lumi-supercomputer.eu/software/installing/spack/).

    **NB!** _Program installation will require time up to hours._

5. When the program is already installed, the user should load it before use by commands:

    ```sh
    module load program_name
    ```

### Installation by EasyBuild

1. To install a program with **EasyBuild**, initialize it by the following commands:

    ```sh
    module use /projappl/project_XXXX/easybuild/modules/all
    module list
    ```

    where the project `XXX` number can be found in [ETAIS](https://etais.ee) as `Effective ID`.

    After, the user should load the following modules:

    ```sh
    module load LUMI/YYY partition/ZZZ 
    module load EasyBuild-user
    ```

    where `YYY` is the version of LUMI that can be found on the program's page in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).  
    Sometimes partition `ZZZ` is determined in the description of the program in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/). In case it is not, partition `ZZZ` is used depending on whether CPUs (partition/C) or GPUs (partition/G) will be used.

    ![list-EB](/access/attachments/list-eb.png)

2. After EasyBuild is loaded, the user can install the program needed by the command `eb`.

    ```sh
    eb program_eb_file
    ```

    **NB!** _The full name of `program_eb_file` as well as some additional flags needed for installation can be found on the program's page in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)._

    **NB!** _Program installation will require time up to an hour._

3. When the program is already installed, the user should load it before use by commands:

    ```sh
    module load program_name
    ```

## Loading program & adding modules into Slurm

When the program is already installed, the user should load it before use or add it into the Slurm script. If the program was installed by **SPACK**, the following commands should be given:

```sh
export SPACK_USER_PREFIX=/project/project_XXX/spack
module load LUMI/YYY partition/ZZZ 
module load spack/YYY
module load program_name/VVV
```

where `XXX` is a project number, and can be found in [ETAIS](https://etais.ee) as `Effective ID`.  
`YYY` is the version of LUMI, which will appear in the module list.  
Partition `ZZZ` is determined depending on whether CPUs (partition/C) or GPUs (partition/G) will be used.  
`RRR` is the version of **SPACK**, which will appear in the module list.  
`VVV` is the version of the program, which will appear in the module list.

If the program was installed by **EasyBuild**, the following commands should be given:

```sh
module use /projappl/project_465000338/easybuild/modules/all
module load LUMI/YYY partition/ZZZ 
module load EasyBuild/
module load program_name/VVV
```

where `XXX` is a project number, and can be found in [ETAIS](https://etais.ee) as `Effective ID`.  
`YYY` is the version of LUMI, which will appear in the module list.  
Partition `ZZZ` is determined depending on whether CPUs (partition/C) or GPUs (partition/G) will be used.  
`RRR` is the version of **SPACK**, which will appear in the module list.  
`VVV` is the version of the program, which will appear in the module list.

Examples of Slurm scripts can be found [here](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/slurm-quickstart/).

## Uninstalling Programs

To uninstall a program installed by **SPACK**, use the following command:

```sh
spack uninstall program_name@version
```

For example:

```sh
spack uninstall nwchem@7.0.2
```

To uninstall a program installed by **EasyBuild**, use the following command:

```sh
eb -r program_eb_file
```

For example:

```sh
eb -r GROMACS-2020.4-foss-2020a.eb
```

Make sure to replace `program_name@version` and `program_eb_file` with the actual program name and version or EasyBuild file name.

For more details, refer to the [LUMI documentation](https://docs.lumi-supercomputer.eu/software/uninstalling/).
