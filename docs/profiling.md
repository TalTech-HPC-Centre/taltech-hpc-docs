<span STYLE="font-size:14mm"> <span style="color:red">not changed to rocky yet</span></span>

# Profiling

Is the skill and art of finding which part of your code needs the most time, and therefore to find the place where you can (should, need to) optimize (first). The optimization can be different things, like using library functions instead of self-written ones, re-arranging memory access, removing function calls, writing C/Fortran functions for your Python code.

The profiling can be done manually by adding time and print statements to your code or (better) by using tools like Valgrind, TAU, HPCToolkit, Score-P or Python's Scalene or cProfile.

Tools to profile applications and perform efficiency, scaling and energy analysis are described in this document by the Virtual Institute High Performance Computing: [https://www.vi-hps.org/cms/upload/material/general/ToolsGuide.pdf](https://www.vi-hps.org/cms/upload/material/general/ToolsGuide.pdf)

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Monitoring jobs on the node

---

It is possible to submit a second (this time) interactive job to the node where the main job is running, check with `squeue` where your job is running, then submit

    srun -w <nodename> --pty htop

Note that there must be free slots on the machine, so you cannot use `-n 80` or `--exclusive` for your main job (use `-n 78`).

Alternative method if you have X11, e.g. on Linux computers:

When you login to base, use `ssh -X -Y UniID@base.hpc.taltech.ee`,

then submit your main job with `srun --x11 -n <numtasks> --cpus-per-task=<numthreads> --pty bash
and start an `xterm -e htop &` in the session.

In `sbatch` the option `--x11=batch` can be used, note that the ssh session to base needs to stay open!

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Valgrind

---

Manual: [http://valgrind.org/docs/manual/manual.html](http://valgrind.org/docs/manual/manual.html)

Valgrind is an instrumentation framework for building dynamic analysis tools. There are Valgrind tools that can automatically detect many memory management and threading bugs, and profile your programs in detail. You can also use Valgrind to build new tools.

The Valgrind distribution currently includes seven production-quality tools: a memory error detector, two thread error detectors, a cache and branch-prediction profiler, a call-graph generating cache and branch-prediction profiler, and two different heap profilers. It also includes an experimental SimPoint basic block vector generator. 

### _Callgrind_

### _Cachegrind_



<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _Profiling Python_

---

Python is *very* slow, the best improvement is achieved by rewriting (parts of) the program in Fortran or C.
See also "Python Performance Matters" by Emery Berger (Strange Loop 2022) [https://www.youtube.com/watch?v=vVUnCXKuNOg](https://www.youtube.com/watch?v=vVUnCXKuNOg)


### _Python Scalene_

Scalene is a CPU, GPU and memory profiler for Python that is very performant (introduces very little overhead).

Installation: load your favourite Python module, e.g.

    module load green-spack
    module load python/3.8.7-gcc-10.3.0-plhb
    py-pip/21.1.2-gcc-10.3.0-python-3.8.7-bj7d

then install using pip:

    python -m pip install --user scalene


Homepage and quickstart: [https://github.com/plasma-umass/scalene](https://github.com/plasma-umass/scalene)


### _Python cProfile_



<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>


## perf

---

[https://perf.wiki.kernel.org/index.php/Main_Page](https://perf.wiki.kernel.org/index.php/Main_Page)

perf is powerful: it can instrument CPU performance counters, tracepoints, kprobes, and uprobes (dynamic tracing). It is capable of lightweight profiling. It is also included in the Linux kernel, under tools/perf, and is frequently updated and enhanced.

perf began as a tool for using the performance counters subsystem in Linux, and has had various enhancements to add tracing capabilities.


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _TAU, Jumpshot, Paraprof_

---

TAU can be used for *profiling* and for *MPI tracing* (not at the same time, though). See e.g. <https://wiki.mpich.org/mpich/index.php/TAU_by_example>


Load the spack TAU module:

    module load green-spack
    module load tau/2.30.2-gcc-10.3.0-2wge

**Profiling**

TAU supports different methods of instrumentation:

    - Dynamic: statistical sampling of a binary through preloading of libraries
    - Source: parser-aided automatic instrumentation at compile time
    - Selective: a subcategory of source, it is automatic, but guided source code instrumentation

The simplest and only for existing binary software is dynamic profiling through `tau_exec`, just run

    srun tau_exec your_program

several `profile.*` files will be created. This method can unfortunately only profile MPI functions and not user-defined ones.
Note, that profile files are only generated if the program exits normally, not if an error occurs or SLURM kills it!

You can generate reports with `pprof` and visualize with `paraprof`.


**MPI tracing**

The tracing can take a lot of space, it is not uncommon that tracefiles are several GB in size for each MPI-task!

    export TAU_TRACE=1
    srun  -n 2 tau_exec ./pingpong-lg-mpi4
    tau_treemerge.pl

TAU does not have a tracing visualizer, but provides tools to convert its traces to other formats, e.g. slog2 for jumpshot, otf(2) or paraver:

    tau2slog2 tau.trc tau.edf -o tau.slog2
    tau_convert -paraver tau.trc tau.edf trace.prv

The traces can be visualized using `jumpshot` (in the tau module), just run

    jumpshot tau.slog2

jumpshot may open a huge window (larger than screen size), in this case use the "maximize" option of your window manager (fvwm: in the left window corner menu), jumpshot opens 3 windows: "jumpshot-4", "Legend" and "Timeline" (if you cannof find them, use window manager menu, e.g. fvwm: right mouse button on desktop background).


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _EZTrace + ViTE_

---

[EZTrace 1.1](https://eztrace.gitlab.io/eztrace/eztrace-1/tutorials/tutorial_mpi/) and [ViTE 1.2](https://eztrace.gitlab.io/eztrace/eztrace-1/tutorials/tutorial_mpi/) are installed on **amp** and **viz**.

EZTrace is a tool to analyze event traces, it has several modules:

    stdio   Module for stdio functions (read, write, select, poll, etc.)
    starpu  module for StarPU framework
    pthread Module for PThread synchronization functions (mutex, semaphore, spinlock, etc.)
    papi    Module for PAPI Performance counters
    openmpi Module for MPI functions
    memory  Module for memory functions (malloc, free, etc.)


ViTE is the visualization tool to visualize the generated traces, it can visualize also .otf2 traces obtained from other MPI tracing tools (e.g. converted from TAU)

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _HPCToolkit_

---

Load modules

    module load hpctoolkit

run application with binary instrumentation

    srun -n 2 -p green-ib hpcrun <your_application>
    hpcstruct `which <your_application>`
    hpcprof hpctoolkit-<your_application>-measurements-<PID>

run GUI tool for interpretation

    hpcviewer hpctoolkit-<your_application>-database-<PID>

starts `hpcviewer` and opens the database.


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _Paraver trace visualizer_

---

Load the module

    module load green
    
    module load Paraver

start paraver

    wxparaver

then load the .prv trace file



<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _Extrae_

---


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _Score-P_

---

Scalable Performance Measurement Infrastructure for Parallel Codes

    module load green-spack
    module load scorep

The module with hash "mlw5" contains the PDT instrumenter.
The module with hash "o4v3" contains the PDT instrumenter and libunwind.


https://scorepci.pages.jsc.fz-juelich.de/scorep-pipelines/docs/scorep-4.1/html/quickstart.html

compilation: prefix the compiler command with "scorep", e.g. `scorep gcc ...` or `scorep mpicc ...`, this can also be used in Makefiles:

    MPICC = $(PREP) mpicc

(and analogously for linkers and other compilers). One can then use the same makefile to either build an instrumented version with the

    make PREP="scorep"

a simple `make` will generate an uninstrumented binary.


The environment variables SCOREP_ENABLE_TRACING and SCOREP_ENABLE_PROFILING control whether event trace data or profiles are stored in this directory. By setting either variable to true, the corresponding data will be written to the directory. The default values are true for SCOREP_ENABLE_PROFILING and false for SCOREP_ENABLE_TRACING.



<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _Scalasca_

---

Scalasca is a software tool that supports the performance optimization of parallel programs by measuring and analyzing their runtime behavior. The analysis identifies potential performance bottlenecks – in particular those concerning communication and synchronization – and offers guidance in exploring their causes.


    module load green-spack
    module load scalasca




<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _Open|SpeedShop_

---

    module load green-spack
    module load openspeedshop
    module load openspeedshop-utils


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _DiscoPoP_

---

to be installed

analyses source-code to find areas that can be parallelized

works only with LLVM 11.1 (included in the module)

    module load green
    module load discopop


<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _PGI / Nvidia HPC SDK_

---

On the GPU servers, the Nvidia HPC SDK is installed, which contains the PGI compilers and profilers.




<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## _IgProf_

---

The Ignominous Profiler. IgProf is a simple nice tool for measuring and analysing application memory and performance characteristics. IgProf requires no changes to the application or the build process.

Quick start: [https://igprof.org/running.html](https://igprof.org/running.html)



