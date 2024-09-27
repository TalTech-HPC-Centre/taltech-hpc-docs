# Visualization

!!! tip
    The recommended way of doing visualizations is now using the **desktop session** on [ondemand.hpc.taltech.ee](https://ondemand.hpc.taltech.ee).

## OnDemand Desktop on any node (software rendering)

The default desktop environment is XFCE, which is configurable, lightweight, and fast.

The menu only contains a couple of programs from the operating system.

To start software, open an XTerminal and use the module system as you would from the command line and start the program from there.

---

## Accessing the visualization system

The visualization computer `viz.hpc.taltech.ee` can be accessed by SSH from within the university network, from FortiVPN, or using a jump host:

```sh
ssh viz.hpc.taltech.ee
ssh viz -J base.hpc.taltech.ee
```

Access to **viz** is limited to using SSH keys, no password login. Therefore, the SSH key must be copied to **base**. More can be found [here](/access/ssh#getting-ssh-keys-to-work).

The **base** home directories are shared with **viz**.

---

## Using GUI software remotely

The visualization software can be executed directly on the visualization node of the cluster, thus removing the need to copy the data for the analysis. There are several possibilities to use graphical programs remotely on a Linux/Unix server:

- Remote X, forwarding through SSH
- [X2GO](/visualization/x2go)
- [Xpra](/visualization/xpra)
- [VNC](/visualization/vnc)
- RDP (currently not installed)
- [VirtualGL](/visualization/VirtualGL)

At least one of these methods should work for any user, which one depends on the configuration of the client computer (your desktop/laptop).

These methods also have different requirements for what client software needs to be installed on your computer:

- SSH, e.g., PuTTY on Windows (essential)
- X-server (essential for X-forwarding, Xpra, VirtualGL; not needed for X2GO, VNC) (installed by default on Linux; for Windows [Xming](https://sourceforge.net/projects/xming/) or [VcXsrv](https://sourceforge.net/projects/vcxsrv/)) for Mac ([XQuartz](https://www.xquartz.org/))
- [Xpra](https://xpra.org/)
- [TightVNCViewer](https://www.tightvnc.com/download.php)
- [VirtualGL](https://virtualgl.org/)

SSH is essential on all platforms, an X-server and VirtualGL are highly recommended, and Xpra and VNC are recommended to have on the client computer.

---

### _Window manager or Desktop environment for remote use_

The default window manager for VNC and X2GO is FVWM2, a configurable, lightweight, and fast window manager.

You can get a context menu by clicking on the background (left, middle, and right give different menus). By the way, a nice X11 feature is easy copy-and-paste, marking with the left mouse button automatically puts the selection into a copy buffer and clicking the middle mouse button inserts it at the current mouse cursor position. No annoying ctrl+c, ctrl+v necessary.

Within VNC or X2GO, you are running a complete desktop session. Typical modern desktop environments require a lot of memory just for the desktop environment! For this reason, only resource-efficient window managers like `jwm`, `fvwm2`, `awesome`, `lwm`, `fluxbox`, `blackbox`, `xmonad`, and `tritium` are installed.

Software to be automatically started can be configured in `.xsession` (or `.vnc/xstartup` or `.xsessionrc-x2go`).

### _Available Visualization software on compute nodes_

- ParaView
- VisIt
<!-- -   COVISE -->
- Py-MayaVi
<!-- -   OpenDX -->
- RasMol
- VESTA
<!-- -   VAPOR -->
- VMD
- Ovito
- Ospray (raytracer)
- PoVray (raytracer)

## OnDemand Desktop on GPU nodes (hardware rendering)

Requires, of course, to be submitted to a GPU node and a GPU to be reserved. The nodes are configured in a way that requires EGL rendering and therefore may require other modules to be loaded (e.g., ParaView).

Otherwise, the Desktop works as the regular (software rendering) one, see above.

Please note that for most applications, software rendering is fast enough. Only heavy visualization, like volume visualization in ParaView, COVISE, VisIt, VMD, Star-CCM+, and Ansys, may require GPU rendering.

## In-situ visualization (in preparation)

In-situ visualization creates the visualization during the simulation instead of during the post-processing phase. The simulation code needs to be connected to in-situ visualization libraries, e.g., Catalyst (ParaView), LibSim (VisIt), and Ascent.

The following are installed on our cluster:

- [Catalyst](https://www.paraview.org/insitu/)
- [Ascent](https://github.com/Alpine-DAV/ascent)
- LibSim
- SENSEI

Ascent on all nodes:

```bash
module load rocky8-spack
module load ascent
```

Catalyst on all nodes:

```bash
module load rocky8-spack
module load libcatalyst/2.0.0-gcc-10.3.0-openblas-bp26
```

Catalyst can be used within OpenFOAM and [NEK5000](https://github.com/KTH-Nek5000/InSituPackage) simulations.
