<span style="color:orange">only partially changed to rocky yet</span>

# GPU-servers


<span style="color:blue">job submission from "base"</span>

<span style="color:red">The AI-lab "Illukas" modules will NOT work on the cluster due to different OS</span>

<br>
<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Hardware

---


 <div class="simple1"> <b>amp1</b> 

- CPU: 2x AMD EPYC 7742 64core (2nd gen EPYC, Zen2)
- RAM: 1 TB 
- GPUs: 8x A100 Nvidia 40GB
- OS: Rocky8
 </div> 
 <br>

 <div class="simple1"> <b>amp2</b> 

- CPU: 2x AMD EPYC 7713 64core (3rd gen EPYC, Zen3)
- RAM: 2 TB
- GPUs: 8x A100 Nvidia 80GB
- OS: Rocky8
 </div> 
 <br>
 
 <div class="simple1"> <b>ada[1,2]</b> 

- CPU: 2x AMD EPYC 9354 32core (4th gen EPYC, Zen4)
- RAM: 1.5 TB
- GPUs: 2x L40 Nvidia 48GB
- avx512
- OS: Rocky8
 </div> 
 <br>


<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Login and localstorage

---

No direct login, jobs are submitted from "base", use `srun -p gpu --gres=gpu:L40 --pty bash`

amp[1,2] have `/localstorage` a 10 TB NVMe partition for fast data access. Data in directory has a longer storage duration than data in the 4 TB `/tmp` (`/state/partition1` is the same as `/tmp`)


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Running jobs 

---

Jobs need to be submitted using `srun` or `sbatch`, do not run jobs outside the batch system.

Interactive jobs are started using `srun`:

    srun -p gpu -t 1:00:00 --pty bash

GPUs have to be reserved/requested with:

    srun -p gpu --gres=gpu:A100:1 -t 1:00:00 --pty bash

all nodes with GPUs are in the same partition (`-p gpu`, but also in `short`, which has higher priority, but shorter time-limit) so jobs that do not have specific requirements can run on any of the nodes. If you need a specific type, e.g. for testing performance or because of memory requirements: 
 - it is possible to request the feature "A100-40" (for the 40GB A100s), "A100-80" (for the 80GB A100s):** `--gres=gpu:A100:1 --constraint=A100-80` or `--gres=gpu:1 --constraint=A100-40`

- it is also possible to request the"compute capability, e.g. nvcc80 (for A100) or nvcc89 (for L40) using `--gres=gpu:1 --constraint=nvcc89` = `--gres=gpu:L40:1`

 - another option is to request the job to run on a specific node, using the `-w` switch (e.g. `srun -p gpu -w amp1 --gres=gpu:A100:1 ... `)


You can see which GPUs have been assigned to your job using `echo $CUDA_VISIBLE_DEVICES`, **the CUDA-deviceID in your programs always start with "0" (no matter which physical GPU was assigned to you by SLURM)**.



<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Software and modules 

---

same modules as on all nodes, i.e. the rocky8 and rocky8-spack modules.


### _From AI lab_

will not work due to different OS


### _Software that supports GPUs_

- JupyterLab, see page on [JupyterLab](data-analysis/jupyter.md)
- Gaussian, see page on [Gaussian](chemistry/gaussian.md)
- cp2k
- StarCCM+
- Julia
- Chapel
- Singularity (apptainer), see page on [Singularity](singularity.md)



<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>


<span style="color:orange">only partially changed to rocky yet</span>



## GPU libraries and tools

---

The GPUs installed are Nvidia A100 with compute capability 80, compatible with CUDA 11. However, when developing own software, be aware of vendor lockin, CUDA is only available for Nvidia GPUs and does not work on AMD GPUs. Some new supercomputers (LUMI (CSC), El Capitan (LLNL), Frontier (ORNL)) are using AMD, and some plan the Intel "Ponte Vecchio" GPU (Aurora (ANL), SuperMUC-NG (LRZ)). To be future-proof, portable methods like OpenACC/OpenMP are recommended.

Porting to AMD/HIP for LUMI: <https://www.lumi-supercomputer.eu/preparing-codes-for-lumi-converting-cuda-applications-to-hip/>


### _Nvidia CUDA 11_

Again, beware of the vendor lockin.


To compile CUDA code, use the Nvidia compiler wrapper:

    nvcc


### _Offloading Compilers_

- PGI (Nvidia HPC-SDK) supports OpenACC and OpenMP offloading to Nvidia GPUs
- GCC-10.3.0
- GCC-11.2.0 with NVPTX supports GPU-offloading using OpenMP and OpenACC pragmas
- LLVM-13.0.0 (Clang/Flang) with NVPTX supports GPU-offloading using OpenMP pragmas
<br>

See also: <https://lumi-supercomputer.eu/offloading-code-with-compiler-directives/>




### _OpenMP offloading_

Since version 4.0 supports offloading to accelerators. It can be utilized by GCC, LLVM (C/Flang) and Nvidia HPC-SDK (former PGI compilers).

- GCC-10.3.0
- GCC-11.2.0 with NVPTX supports GPU-offloading using OpenMP and OpenACC pragmas
- LLVM-13.0.0 (Clang/Flang) with NVPTX supports GPU-offloading using OpenMP pragmas
- AOMP 
<br>

List of compiler support for OpenMP: <https://www.openmp.org/resources/openmp-compilers-tools/>

Current recommendation: use Clang or GCC or AOMP


#### _Nvidia HPC SDK_

Compile option `-⁠mp` for CPU-OpenMP or `-mp=gpu` for GPU-OpenMP-offloading.


The table below summarizes useful compiler flags to compile you OpenMP code with offloading.

| | NVC/NVFortran |	Clang/Cray/AMD	 |GCC/GFortran |
|-------------|-----|----------|----------|
| OpenMP flag |	-mp |	-fopenmp |	-fopenmp -foffload=<target> |
| Offload flag |	-mp=gpu	 |-fopenmp-targets=<target> |	-foffload=<target> |
| Target NVIDIA	 | default |	nvptx64-nvidia-cuda |	nvptx-none |
| Target AMD |	n/a |	amdgcn-amd-amdhsa |	amdgcn-amdhsa |
| GPU Architecture |	-gpu=<cc> |	-Xopenmp-target -march=<arch> |	-foffload=”-march=<arch> |
 




### _OpenACC offloading_

OpenACC is a portable compiler directive based approach to GPU computing. It can be utilized by GCC, (LLVM (C/Flang)) and Nvidia HPC-SDK (former PGI compilers).

Current recommendation: use HPC-SDK


#### _Nvidia HPC SDK_

Installed are versions 21.2, 21.5 and 21.9 (2021). These come with modulefiles, to use them, enable the the directory:

    module load rocky8-spack
    
then load the module you want to use, e.g.

    module load nvhpc

The HPC SDK also comes with a profiler, to identify regions that would benefit most from GPU acceleration.

OpenACC is based on compiler pragmas enabling an incremental approach to parallelism (you never break the sequential program), it can be used for CPUs (multicore) and GPUs (tesla). 

Compiling an OpenACC program with the Nvidia compiler:
get accelerator information

    pgaccelinfo

compile for multicore (C and Fortran commands)

    pgcc -fast -ta=multicore -Minfo=accel -I/opt/nvidia/hpc_sdk/Linux_x86_64/21.5/cuda/11.3/targets/x86_64-linux/include/  -o laplace jacobi.c laplace2d.c
    pgfortran -fast -ta=multicore  -Minfo=accel -I/opt/nvidia/hpc_sdk/Linux_x86_64/21.5/cuda/11.3/targets/x86_64-linux/include/ -o laplace_multicore laplace2d.f90 jacobi.f90

compile for GPU (C and Fortran commands)

    pgcc -fast -ta=tesla -Minfo=accel  -I/opt/nvidia/hpc_sdk/Linux_x86_64/21.5/cuda/11.3/targets/x86_64-linux/include/ -o laplace_gpu jacobi.c laplace2d.c
    pgfortran -fast -ta=tesla,managed -Minfo=accel -I/opt/nvidia/hpc_sdk/Linux_x86_64/21.5/cuda/11.3/targets/x86_64-linux/include/ -o laplace_gpu laplace2d.f90 jacobi.f90

Profiling:

    nsys profile -t nvtx --stats=true --force-overwrite true -o laplace ./laplace
    nsys profile -t openacc --stats=true --force-overwrite true -o laplace_data_clauses ./laplace_data_clauses 1024 1024

Analysing the profile using CLI:

    nsys stat s laplace.qdrep

using the GUI:

    nsys-ui

then load the `.qdrep` file.


#### _GCC (needs testing)_

- GCC-10.3.0
- GCC-11.2.0 with NVPTX supports GPU-offloading using OpenMP and OpenACC pragmas


<br>

### _HIP (upcoming)_

For porting code to AMD-Instinct based LUMI, the AMD HIP SDK will be installed.


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>



<br>
<br>
