<span style="color:red">not changed to rocky yet</span>

## Hardware Specification

The use of the resources of the TalTech [HPC Centre](https://taltech.ee/en/itcollege/hpc-centre) requires an active Uni-ID account, a procedure for non-employees/non-students can be found [here](https://taltech.atlassian.net/wiki/spaces/ITI/pages/38996020/Uni-ID+lepinguv+line+konto) (in Estonian).


TalTech operates the following infrastructure:


-   **base.hpc.taltech.ee** is the new cluster environment all nodes from HPC1 and HPC2 will be migrated here
    -   a live diagram of the cluster load is here: [load diagram](https://base.hpc.taltech.ee/load/)
    -   UniID login (please ask at hpcsupport@taltech.ee to activate access)
    -   SLURM v20 scheduler
    -   CentOS 7
    -   home-directories' location: `/gpfs/mariana/home/uni-ID`
    -   HPC1 home-directories accessible under `/beegfs/home/uni-ID`
    -   home directory file system has 1.5 PB storage, with a 2 TB/user quota
    -   **green** nodes (former **hpc2.ttu.ee** nodes)
        -   32 nodes 2 x Intel Xeon Gold 6148 20C 2.40 GHz, **96 GB** DDR4-2666 R ECC RAM (**green[1-32]**)
        -   25 Gbit Ethernet
        -   18 of these nodes are connected with low latency interconnect FDR InfiniBand (**green-ib** partition)
    -   **gray** nodes (former **hpc.ttu.ee** nodes, migration in progress)
        -   48 nodes with 2 x Intel Xeon E5-2630L 6C with **64 GB RAM** and 1 TB local drive connected with low latency interconnect QDR InfiniBand (**gray-ib** partition)
        -   60 nodes with 2 x Intel Xeon E5-2630L 6C with 48 GB RAM and 1 TB local drive (memory upgrade to 64 GB in progress)
        -   1 Gbit Ethernet
    -   **mem1tb** large memory node
        -   1 node with 1TB of operating RAM
        -   4x Intel Xeon CPU E5-4640 (together 32 cores, 64 threads)
    -   **amp** GPU node, [specific guide for amp](gpu.md) (amp.hpc.taltech.ee)
        -   1 node with 8xNvidia A100
        -   2x 64core AMD EPYC 7742 (together 128 cores, 256 threads)
        -   1 TB RAM
        -   OpenACC, OpenMP, OpenCL, CUDA
        -   Ubuntu 20.04
    -   **viz.hpc.taltech.ee** Visualization node (accessible within University network and FortiVPN)
        -   this service is intended mainly for post-processing, especially of large datasets; it is not intended as a remote desktop service; job submission is not possible from here
        -   1 node with 2 nVidia Tesla K20Xm grapic cards (on displays :0.0 and :0.1)
        -   this node is not for computation on GPUs
        -   Debian 10
        -   UniID login with ssh-keys (no password login; previous login on base.hpc.taltech.ee required to create account)
        -   same home-directories as base, HPC1-homes accessible under /beegfs/home/uni-ID
        -   ParaView, VisIt and COVISE available for remote visualization
        -   VirtualGL, Xpra, VNC available for remote execution of programs (can be used with e.g. Mayavi, ParaView, VisIt, COVISE, OpenDX)
    -   **There is no backup** please take care of backups yourself!
    -   **partitions:**
        -   **short**: (*default*) time limit 4 hours, default time 10 min, default mem 1 GB/thread, *green* nodes
        -   **common**: time limit 8 days, default time 10 min, default mem 1 GB/thread, green nodes
        -   **long**: time limit 22 days, default time 10 min, default mem 1 GB/thread, green nodes
        -   **green-ib**: time limit 8 days, default time 10 min, default mem 1 GB/thread, *green* InfiniBand nodes
        -   **gray-ib**: time limit 8 days, default time 10 min, default mem 1 GB/thread, *gray* InfiniBand nodes
        -   **gpu**: *amp* GPU node, time limit 5 days, default time 10 min, default mem 1 GB/thread
        -   **mem1tb**: *mem1tb* node
-   **training.hpc.taltech.ee** virtual training cluster 
    -   used for testing
    -   running on the TalTech ETAIS OpenStack cloud service
-   **TalTech ETAIS Cloud**: 4 node OpenStack cloud
    -   5 compute (nova) nodes with 282GB or 768GB of RAM and 80 threads each
    -   65 TB CephFS storage (net capacity)
    -   accessible through the ETAIS website: <https://etais.ee/using/>
