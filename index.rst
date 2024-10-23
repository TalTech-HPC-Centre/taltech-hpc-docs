.. Front page


HPC Center user guides
======================


.. figure:: pictures/HPC.jpg
   :align: center
   :scale: 100%
   

-----------------------   


The use of the resources of TalTech `HPC Centre`_ requires an active Uni-ID account (an application form for non-employees/non-students can be found `here`_). Further the user needs to be added to the HPC-USERS group, please ask hpcsupport@taltech.ee to activate HPC access from your TalTech e-mail and provide your **UniID (six letters taken from the user's full name**). In the case of using licensed programs, the user must also be added to the appropriate group. `Here can  be found more about available programs and licenses`_.

.. _HPC Centre: https://taltech.ee/en/itcollege/hpc-centre
.. _here: https://taltech.atlassian.net/wiki/spaces/ITI/pages/38996020/Uni-ID+lepinguv+line+konto
.. _Here can  be found more about available programs and licenses: https://docs.hpc.taltech.ee/software.html

TalTech HPC Centre includes `cluster,`_ `cloud`_ and also is responsible for providing access to resources of `LUMI supercomputer.`_

.. _cluster,: https://docs.hpc.taltech.ee/quickstart.html
.. _cloud: https://docs.hpc.taltech.ee/cloud.html
.. _LUMI supercomputer.: https://docs.hpc.taltech.ee/lumi.html
 

The **cloud** provides user ability to create virtual machines where the user has full admin rights and can install all the necessary software by her/himself. VMs can be connected from outside and can be used for providing web services. Accessible through the ETAIS website: https://etais.ee/using/.

The **cluster** has a Linux operating system (based on CentOS; Debian or Ubuntu on special purpose nodes) and uses SLURM as a batch scheduler and resource manager. Linux is the dominating operating system used for scientific computing and of now is the only operating system present in the `Top500`_ list (a list of the 500 most powerful computers in the world). **Linux command-line knowledge is essential for using the cluster.** `Resources on learning Linux`_ can be found in our guide, including introductory lectures in Moodle. However, some graphical interface is available for data visualisation, copy and transfer.

.. _Top500: https://www.top500.org/
.. _Resources on learning Linux: https://docs.hpc.taltech.ee/learning.html

**LUMI supercomputer** is the fastest supercomputer in Europe, the fifth fastest `globally`_  and the seventh `greenest`_ supercomputer on the planet. `Specification of LUMI can be found here.`_

.. _globally: https://www.top500.org/lists/top500/2023/11/
.. _greenest: https://www.top500.org/lists/green500/2023/11/
.. _Specification of LUMI can be found here.: https://docs.hpc.taltech.ee/lumi.html#what-is-lumi

.. raw:: html

      <br>
      <br>
      <hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
      <hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

      
      
Hardware Specification 
-----------------------  

               
----------------------- 


.. ul::

**TalTech ETAIS Cloud:** 5-node OpenStack cloud
     -   5 compute (nova) nodes with **768 GB** of RAM and **80 threads** each
     -   **65 TB** CephFS storage (net capacity)
     -   accessible through the ETAIS website: https://etais.ee/using/       
     
.. ul::

**TalTech cluster base** (base.hpc.taltech.ee):
     -   SLURM v23 scheduler, a live `load diagram`_
     -   1.5 PB storage, with a **0.5 TB/user** quota on $HOME and **2 TB/user** quota on SMBHOME
     -   32 **green** nodes, 2 x Intel Xeon Gold 6148 20C 2.40 GHz (**40 cores, 80 threads** per node), **96 GB** DDR4-2666 R ECC RAM (**green[1-32]**), 25 Gbit Ethernet, 18 of these FDR InfiniBand (**green-ib** partition)
     -   1 **mem1tb** large memory node, **1 TB** RAM, 4x Intel Xeon CPU E5-4640 (together **32 cores, 64 threads**)
     -   2 **ada** GPU nodes, 2xNvidia L40/48GB, 2x 32core AMD EPYC 9354 Zen4 (together **64 cores, 128 threads**), **1.5 TB** RAM** 
     -   **amp** GPU nodes (`specific guide for amp and amp1`_): 
     	-    **amp:** 8xNvidia A100/40GB, 2x 64core AMD EPYC 7742 Zen (together **128 cores, 256 threads**), **1 TB** RAM;
        -    **amp2:** 8xNvidia A100/80GB, 2x 64core AMD EPYC 7713 zen3 (together **128 cores, 256 threads**), **2 TB** RAM
     -   Visualization node **viz** (accessible within University network and `FortiVPN`_, `guide for viz`_): 2xNvidia Tesla K20Xm graphic cards (on displays :0.0 and :0.1), CPU Intel(R) Xeon(R) CPU E5-2630L v2@2.40GHz (**24 threads**), **64 GB** RAM, HDD **2 TB** storage.

     
.. _load diagram: https://base.hpc.taltech.ee/load/
.. _specific guide for amp and amp1: gpu.html
.. _FortiVPN: https://taltech.atlassian.net/wiki/spaces/ITI/pages/38994267/Kaug+hendus+FortiClient+VPN+Remote+connection+with+FortiClient+VPN
.. _guide for viz: visualization.html

-----------------------  


.. raw:: html

      <hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
      <hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

      
      
Billing
----------------------- 

               
----------------------- 

**Virtual server hosting**
 

.. list-table:: 
   :align: center
   :widths: 26 26 26 26
   :header-rows: 1

   * - What
     - Unit
     - TalTech internal
     - External
   * - CPU
     - CPU*hour
     - 0.002 EUR
     - 0.003 EUR
   * - Memory
     - RAM*hour
     - 0.001 EUR
     - 0.0013 EUR
   * - Storage
     - TB*year
     - 20 EUR
     - 80 EUR

**TalTech cluster**
 

.. list-table:: 
   :align: center
   :widths: 22 22 22 22
   :header-rows: 1

   * - What
     - Unit
     - TalTech internal
     - External
   * - CPUcore & < 6 GB RAM
     - CPUcore*hour
     - 0.006 EUR
     - 0.012 EUR
   * - CPUcore & > 6 GB RAM
     - 6 GB RAM*hour
     - 0.006 EUR
     - 0.012 EUR
   * - GPU
     - GPU*hour
     - 0.20 EUR
     - 0.50 EUR
   * - Storage
     - 1 TB*Year
     - 20 EUR
     - 80 EUR

More details how to calculate computational costs for TalTech cluster can be found in `Monitoring resources part of Quickstart page`_ .


**LUMI cluster for users from Estonia**


.. list-table:: 
   :align: center
   :widths: 32 22 22
   :header-rows: 1

   * - What
     - Unit
     - Price for TalTech
   * - CPUcore
     - CPUcore*hour
     - 0.008 EUR
   * - GPU
     - GPU*hour
     - 0.35 EUR
   * - User home directory
     - 20 GB
     - free
   * - Project storage (persistent and scratch)
     - TB*hour 
     - 0.0106 EUR
   * - Flash based scratch storage
     - TB*hour 
     - 10 x 0.0106 EUR


More detail guide how to calculate computational costs for LUMI can be found in `LUMI billing policy`_.


.. _Monitoring resources part of Quickstart page: https://docs.hpc.taltech.ee/quickstart.html#monitoring-resource-usage
.. _LUMI billing policy: https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/#compute-billing


-----------------------  


.. raw:: html

      <hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
      <hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

      
      
SLURM partitions
----------------------- 

               
----------------------- 


.. list-table:: 
   :align: center
   :widths: 22 22 22 22 22
   :header-rows: 1

   * - partition
     - default time
     - time limit
     - default memory
     - nodes
   * - **short**
     - 10 min
     - 4 hours
     - 1 GB/thread
     - green, ada, amp
   * - **common**
     - 10 min
     - 8 days
     - 1 GB/thread
     - green
   * - **green-ib**
     - 10 min
     - 8 days
     - 1 GB/thread
     - green
   * - **long**
     - 10 min
     - 22 days
     - 1 GB/thread
     - green
   * - **gpu**
     - 10 min
     - 5 days
     - 1 GB/thread
     - amp, ada
   * - **bigmem**
     - 10 min
     - 8 days
     - 1 GB/thread
     - ada, amp, mem1tb 


-----------------------  
  
.. raw:: html

      <hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
      <hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

      
      
Contents:
----------------------- 

               
----------------------- 


.. toctree::
   :maxdepth: 3  
 
   lumi
   cloud 
   quickstart 
   learning 
   modules
   software    
   mpi  
   performance
   profiling
   visualization
   gpu
   singularity
   acknowledgement

   
  
