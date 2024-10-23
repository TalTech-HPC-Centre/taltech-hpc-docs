---
hide:
  #- navigation
  - toc
title: Welcome to TalTech HPC User Guides!
---

# Welcome to TalTech HPC User Guides!

![HPC](/pictures/HPC.jpg)

---

The use of the resources of the TalTech [HPC Centre](https://taltech.ee/en/itcollege/hpc-centre) requires an active Uni-ID account (an application form for non-employees/non-students can be found [here](https://taltech.atlassian.net/wiki/spaces/ITI/pages/38996020/Uni-ID+lepinguv+line+konto)). Further, the user needs to be added to the HPC-USERS group. Please ask [hpcsupport@taltech.ee](mailto:hpcsupport@taltech.ee) to activate HPC access from your TalTech email and provide your **UniID (six letters taken from the user's full name**). In the case of using licensed programs, the user must also be added to the appropriate group. More information about available programs and licenses can be found [here](/software/software).

TalTech HPC Centre includes [cluster](/access/cluster), [cloud](/access/cloud) and is also responsible for providing access to the resources of the [LUMI supercomputer](/access/lumi).

The **cloud** provides users the ability to create virtual machines where the user has full admin rights and can install all the necessary software themselves. VMs can be connected from outside and can be used for providing web services. Accessible through the [ETAIS website](https://etais.ee/using/).

The **cluster** has a Linux operating system (based on CentOS; Debian or Ubuntu on special-purpose nodes) and uses SLURM as a batch scheduler and resource manager. Linux is the dominant operating system used for scientific computing and is the only operating system present in the [Top500](https://www.top500.org/) list (a list of the 500 most powerful computers in the world). **Linux command-line knowledge is essential for using the cluster.** [Resources on learning Linux](/learning/learning) can be found in our guide, including introductory lectures in Moodle. However, some graphical interface is available for data visualization, copy, and transfer.

**LUMI supercomputer** is the fastest supercomputer in Europe, the fifth fastest [globally](https://www.top500.org/lists/top500/2023/11/) and the seventh [greenest](https://www.top500.org/lists/green500/2023/11/) supercomputer on the planet. Specifications of LUMI can be found [here](/access/lumi#what-is-lumi).

---

## Hardware Specification

**TalTech ETAIS Cloud:**

- 5-node OpenStack cloud
  - 5 compute (nova) nodes with **768 GB** of RAM and **80 threads** each
  - **65 TB** CephFS storage (net capacity)
  - accessible through the [ETAIS website](https://etais.ee/using/)

**TalTech cluster base (base.hpc.taltech.ee):**

- SLURM v23 scheduler, a live [load diagram](https://base.hpc.taltech.ee/)
- 1.5 PB storage, with a **0.5 TB/user** quota on $HOME and **2 TB/user** quota on SMBHOME
- 32 **green** nodes, 2 x Intel Xeon Gold 6148 20C 2.40 GHz (**40 cores, 80 threads** per node), **96 GB** DDR4-2666 R ECC RAM (**green[1-32]**), 25 Gbit Ethernet, 18 of these FDR InfiniBand (**green-ib** partition)
- 1 **mem1tb** large memory node, **1 TB** RAM, 4x Intel Xeon CPU E5-4640 (together **32 cores, 64 threads**)
- 2 **ada** GPU nodes, 2xNvidia L40/48GB, 2x 32core AMD EPYC 9354 Zen4 (together **64 cores, 128 threads**), **1.5 TB** RAM
- **amp** GPU nodes ([specific guide for amp and amp1](/access/cluster-gpu)):
  - **amp:** 8xNvidia A100/40GB, 2x 64core AMD EPYC 7742 Zen (together **128 cores, 256 threads**), **1 TB** RAM
  - **amp2:** 8xNvidia A100/80GB, 2x 64core AMD EPYC 7713 zen3 (together **128 cores, 256 threads**), **2 TB** RAM
- Visualization node **viz** (accessible within University network and [FortiVPN](https://taltech.atlassian.net/wiki/spaces/ITI/pages/38994267/Kaug+hendus+FortiClient+VPN+Remote+connection+with+FortiClient+VPN), [guide for viz](/visualization/visualization)): 2xNvidia Tesla K20Xm graphic cards (on displays :0.0 and :0.1), CPU Intel(R) Xeon(R) CPU E5-2630L v2@2.40GHz (**24 threads**), **64 GB** RAM, HDD **2 TB** storage.

---

## Billing

### Virtual server hosting

| What    | Unit       | TalTech internal | External  |
|---------|------------|------------------|-----------|
| CPU     | CPU*hour   | 0.002 EUR        | 0.003 EUR |
| Memory  | RAM*hour   | 0.001 EUR        | 0.0013 EUR|
| Storage | TB*year    | 20 EUR           | 80 EUR    |

### TalTech cluster

| What                | Unit           | TalTech internal | External  |
|---------------------|----------------|------------------|-----------|
| CPUcore & < 6 GB RAM| CPUcore*hour   | 0.006 EUR        | 0.012 EUR |
| CPUcore & > 6 GB RAM| 6 GB RAM*hour  | 0.006 EUR        | 0.012 EUR |
| GPU                 | GPU*hour       | 0.20 EUR         | 0.50 EUR  |
| Storage             | 1 TB*Year      | 20 EUR           | 80 EUR    |

More details on how to calculate computational costs for TalTech cluster can be found in the [Monitoring resources part of the Quickstart page](/access/cluster#monitoring-resource-usage).

### LUMI cluster for users from Estonia

| What                    | Unit       | Price for TalTech |
|-------------------------|------------|-------------------|
| CPUcore                 | CPUcore*hour| 0.008 EUR         |
| GPU                     | GPU*hour   | 0.35 EUR          |
| User home directory     | 20 GB      | free              |
| Project storage (persistent and scratch) | TB*hour | 0.0106 EUR |
| Flash based scratch storage | TB*hour | 10 x 0.0106 EUR   |

A more detailed guide on how to calculate computational costs for LUMI can be found in the [LUMI billing policy](https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/#compute-billing).

---

## SLURM partitions

| partition | default time | time limit | default memory | nodes       |
|-----------|--------------|------------|----------------|-------------|
| **short** | 10 min       | 4 hours    | 1 GB/thread    | green, ada, amp |
| **common**| 10 min       | 8 days     | 1 GB/thread    | green       |
| **green-ib** | 10 min    | 8 days     | 1 GB/thread    | green       |
| **long**  | 10 min       | 22 days    | 1 GB/thread    | green       |
| **gpu**   | 10 min       | 5 days     | 1 GB/thread    | amp, ada    |
| **bigmem**| 10 min       | 8 days     | 1 GB/thread    | ada, amp, mem1tb |
