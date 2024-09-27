# Module environment (lmod)

## Short introduction

---

HPC has a module step-system. To use some application, user needs to follow these two steps, and insert applications into the search path:

1. Determine the machine type (eg. amp or green) by command:

  module load rocky8-spack      # for most free programs (SPACK package manager)

  or

  module load rocky8/all        # for licensed programs and some free (non-SPACK managed)
  
1. Load program needed:

  module load tau

The list of available modules can be looked by:

    module avail
  
where:  

**Lic** - a license is required, see user-guide for more information  
**Uni** - commercial software with site licence, number of concurrent processes may be limited  
**Reg** - registration required, see user-guide for more information  
**L** - module is loaded  
**Dp** - deprecated (old modules, which have been superseded by modules in the new structure)  
**O** - obsolete (module moved or superseded by SPACK module)  
**Exp** - Experimental module, used while testing software installation, module name may change or software may be deleted  
**D** - default Module.

---

## Long version

---

The module system is used to manage settings for different applications. Many applications and libraries are not in the standard search path, this way it is possible to install two different versions of the same software/library that would otherwise create conflicts. The module system is used to insert applications into the search path (or remove them from it) on a per user and per occasion basis.

### Useful commands

- All available modules can be looked through by command:

  module avail

  example output:

  ![modules](/software/attachments/modules.png)

  Modules are grouped in a hierarchy, there may be several versions of the same software installed, e.g. of the MPI library. Only one of these can be loaded at a single time. The default module of a group is marked by the `(D)`, if there is only one module in a group this is the default (unmarked).

- To load a certain version of a module/program _(here - Open MPI 4.1.1-gcc-8.5.0-r8-ib)_:

  module load openmpi/4.1.1-gcc-8.5.0-r8-ib 

  To load the default module/program marked `(D)` _(here - Open MPI 4.1.1-gcc-10.3.0-r8-tcp)_:

  module load openmpi/

- To list all loaded modules:

  module list

- Unloading a module _(here - Cuda 11.3.1-gcc-10.3.0-ehi3)_:

  module unload cuda/11.3.1-gcc-10.3.0-ehi3

- Finding a module containing a certain part _(here - fem)_:

  module keyword fem

  Will list all modules that have _"fem"_ in the description:

  ![modules](/software/attachments/modules-1.png)

- To find out more about a specific module _(here - mfem)_:

  module spider mfem

  gives:

  ![modules](/software/attachments/modules-2.png)

- The `module whatis` command gives you a short explanation of what the software is about, e.g.

  ![modules](/software/attachments/modules-3.png)

  or

  ![modules](/software/attachments/modules-4.png)

---

### Files .modulerc.lua and .bashrc

Personal preferences and resources can be specified in the files `.modulerc.lua` and `.bashrc` in the user's `$HOME` directory. For example, it is possible to add a path for own module files for software installed by the user in the user's `$HOME` directory, automatically load some modules on login, and to define one's own "default" modules using the entry `module_version("r/4.1.1-gcc-10.3.0-zwgc","default")` or introduce abbreviations using an entry like `module_alias("z13", "r/4.1.1-gcc-10.3.0-zwgc")` to define a module alias "z13".

Example of `.modulerc.lua` file:

```lua
module_version("r/4.1.1-gcc-10.3.0-zwgc","default")
module_alias("z13","r/4.1.1-gcc-10.3.0-zwgc")

module_version("p/20.2-gcc-10.3.0-python-2.7.18-ij2m","default")
module_alias("p20","p/20.2-gcc-10.3.0-python-2.7.18-ij2m")
```

Example of `.bashrc` file:

```bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
module load rocky8-spack
module load r/4.1.1-gcc-10.3.0-zwgc
```

---

## Module groups

We moved to a new module structure! Modules from `/share/apps/modules` are being retired. Software is compiled for `x86-64` and will run on all nodes (no special optimization). Optimized versions for some software for specific nodes may follow later (or not).

New modules are grouped, you can activate them by loading one or more of the following modules:

| modulegroup   | description                          |
|---------------|--------------------------------------|
| rocky8/all    | manually installed software          |
| rocky8-spack  | software installed with spack package manager |

---

## Modules used on **viz**

In order to make the module system work on **viz**, the following needs to be added to your `$HOME/.bashrc`:

```bash
if [[ $(hostname -s) = viz ]]; then
   source /usr/share/lmod/6.6/init/bash
   module use /gpfs/mariana/modules/system
fi
```

Further access to **viz** and load modules needed. For example:

```bash
ssh -X -A -J UNI-ID@base.hpc.taltech.ee UNI-ID@viz.hpc.taltech.ee

module load viz-spack
module load jmol
```

More about the use of **viz** can be found at [visualization page](/visualization/visualization).

---

## Available modules

Currently, the following modules are available. This serves as an example; please note that the list on this page will be updated very seldom. Use `module avail` after login to get an up-to-date list of the available modules.

By default, SPACK builds optimized for the CPU the software is built on. The packages from the **amp** nodes will work on the **green** nodes but slower than the optimized modules. Conversely, the skylake-optimized modules will try to use hardware features not present on the **green** nodes, so the software will not run there.
