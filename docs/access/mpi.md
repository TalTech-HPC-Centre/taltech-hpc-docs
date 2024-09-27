
# Available MPI Versions (with comparison)

The cluster has OpenMPI installed.

On all nodes:

```bash
module load openmpi/4.1.1-gcc-10.3.0-r8-tcp
```

**NB: Currently, only use TCP transport!**
There are several OpenMPI modules for different versions. Different modules for the same version only differ in environment variables for transport selection.

Normally, OpenMPI will choose the fastest interface. It will try RDMA over Ethernet (RoCE), which causes _"[qelr_create_qp:683] create qp: failed on ibv_cmd_create_qp"_ messages. These can be ignored as it will fail over to IB (higher bandwidth anyway) or TCP.

**NB:** `mpirun` is not available; use `srun`.

For MPI jobs, prefer the **green-ib** partition (`#SBATCH -p green-ib`) or stay within a single node (`#SBATCH -N 1`).

```bash
export OMPI_MCA_btl_openib_warn_no_device_params_found=0 srun ./hello-mpi
```

---

## Layers in OpenMPI

- PML = Point-to-point Management Layer:
  - UCX
- MTL = Message Transfer Layer:
  - PSM
  - PSM2
  - OFI
- BTL = Byte Transfer Layer:
  - TCP
  - openib
  - self
  - sm (OpenMPI 1), vader (OpenMPI 4)

The layers can be confusing. For example, openib was originally developed for InfiniBand but is now used for RoCE and is deprecated for IB. However, on some IB cards and configurations, it is the only working option. Also, the MVAPICH implementation still uses openib (verbs) instead of UCX.

Layers can be selected using environment variables:

To select TCP transport:

```bash
export OMPI_MCA_btl=tcp,self,vader
```

To select RDMA transport (verbs):

```bash
export OMPI_MCA_btl=openib,self,vader
```

To select UCX transport:

```bash
export OMPI_MCA_pml=ucx
```

**NB!** _UCX is not supported on QLogic FastLinQ QL41000 Ethernet controllers._

For further explanations and details, see:

- <https://www.open-mpi.org/faq/?category=tuning>
- <https://www.open-mpi.org/faq/?category=openfabrics>

---

Different MPI implementations exist:

- OpenMPI
- MPICH
- MVAPICH
- IBM Platform MPI (MPICH descendant)
- IBM Spectrum MPI (OpenMPI descendant)
- (at least one for each network and CPU manufacturer)

### OpenMPI

- Available in any Linux or BSD distribution
- Combines technologies and resources from several other projects (incl. LAM/MPI)
- Can use TCP/IP, shared memory, Myrinet, InfiniBand, and other low latency interconnects
- Chooses the fastest interconnect automatically (can be manually chosen too)
- Well integrated into many schedulers (e.g., SLURM)
- Highly optimized
- FOSS (BSD license)

### MPICH

- Highly optimized
- Supports TCP/IP and some low latency interconnects
- (Older versions) DO NOT support InfiniBand (however, it supports MELLANOX IB)
- Available in many Linux distributions
- ? Not integrated into schedulers <!--- is this correct? Maybe, "?" mark is better?--->
- Used to be a PITA to get working smoothly
- FOSS

### MVAPICH

- Highly optimized (maybe slightly faster than OpenMPI)
- Fork of MPICH to support IB
- Comes in many flavors to support TCP/IP, InfiniBand, and many low latency interconnects: OpenSHMEM, PGAS
- Need to install several flavors, and users need to choose the right one for the interconnect they want to use
- Generally not available in Linux distributions
- Not integrated with schedulers (integrated with SLURM only after version 18)
- FOSS (BSD license)

### Recommendation

- Default: use OpenMPI on our clusters
- If unsatisfied with performance and running on a single node or over TCP, try MPICH
- If unsatisfied with performance and running on IB, try MVAPICH

For a comparison, see for example:

- <https://www.chpc.utah.edu/documentation/software/mpilibraries.php>
- <https://stackoverflow.com/questions/2427399/mpich-vs-openmpi>
