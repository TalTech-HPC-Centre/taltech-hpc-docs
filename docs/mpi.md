
# Available MPI versions (and comparison)

The cluster has OpenMPI installed.

On all nodes:

    module load openmpi/4.1.1-gcc-10.3.0-r8-tcp

**NB: Currently only use TCP transport!**
There are several OpenMPI modules for diffrent versions, different modules for the same version only differ in environment variables for transport selection.

Normally, OpenMPI will choose the fastest interface, it will try RDMA over Ethernet (RoCE) which causes _"[qelr_create_qp:683]create qp: failed on ibv_cmd_create_qp"_ messages, these can be ignored, it will fail over to IB (higher bandwidth anyway) or TCP.

**NB:** `mpirun` is not available, use `srun`


For MPI jobs prefer the **green-ib** partition (`#SBATCH -p green-ib`) or stay within a single node (`#SBATCH -N 1`).

    export OMPI_MCA_btl_openib_warn_no_device_params_found=0 srun ./hello-mpi

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Layers in OpenMPI

---

- PML = Point-to-point Management Layer:
   - UCX
- MTL = Message Transfer Layer:
   - PSM, 
   - PSM2, 
   - OFI
- BTL = Byte Transfer Layer:
   - TCP, 
   - openib
   - self
   - sm (OpenMPI 1), vader (OpenMPI 4)
<br>


The layers can be confusing, so was openib originally developed for InfiniBand, but is now used for RoCE and is deprecated for IB. However, on some IB cards and configurations it is the only working option. Also, the MVAPICH implementation still uses the openib (verbs) instead of UCX.


Layers can be selected using environment variables:

To select TCP transport:

    export OMPI_MCA_btl=tcp,self,vader

To select RDMA transport (verbs):

    export OMPI_MCA_btl=openib,self,vader

To select UCX transport:

    export OMPI_MCA_pml=ucx





***NB!*** _UCX is not supported on QLogic FastLinQ QL41000 Ethernet controllers._



<div class="simple1">
For further explanations and details see:

- <https://www.open-mpi.org/faq/?category=tuning>
- <https://www.open-mpi.org/faq/?category=openfabrics>
</div>
<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Different MPI implementations exist:

---

-   OpenMPI
-   MPICH
-   MVAPICH
-   IBM Platform MPI (MPICH descendant)
-   IBM Spectrum MPI (OpenMPI descendant)
-   (at least one for each network and CPU manufacturer)
<br>

### OpenMPI

-   available in any Linux or BSD distribution
-   combining technologies and resources from several other projects (incl. LAM/MPI)
-   can use TCP/IP, shared memory, Myrinet, Infiniband and other low latency interconnects
-   chooses fastest interconnect automatically (can be manually choosen, too)
-   well integrated into many schedulers (e.g. SLURM)
-   highly optimized
-   FOSS (BSD license)
<br>

### MPICH

-   highly optimized
-   supports TCP/IP and some low latency interconnects
-   (older versions) DO NOT support InfiniBand (however, it supports MELLANOX IB)
-   available in many Linux distributions
-   ? not intgrated into schedulers <!--- is this correct? Maybe, "?" mark is better?--->
-   used to be a PITA to get working smoothly
-   FOSS
<br>

### MVAPICH

-   highly optimized (maybe slightly faster than OpenMPI)
-   fork of MPICH to support IB
-   comes in many flavors to support TCP/IP, InfiniBand and many low latency interconnects: OpenSHMEM, PGAS
-   need to install several flavors and users need to choose the right one for the interconnect they want to use
-   generally not available in Linux distributions
-   not integrated with schedulers (integrated with SLURM only after version 18)
-   FOSS (BSD license)
<br>

### Recommendation

-   default: use OpenMPI on our clusters
-   if unsatisfied with performance and running on single node or over TCP, try MPICH
-   if unsatisfied with performance and running on IB try MVAPICH
<br>
<div class="simple1">
For a comparison, see for example:

-   <https://www.chpc.utah.edu/documentation/software/mpilibraries.php>
-   <https://stackoverflow.com/questions/2427399/mpich-vs-openmpi>
</div>
<br>
<br>
