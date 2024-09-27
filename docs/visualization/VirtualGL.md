# Remote visualization using VirtualGL

!!! warning
    This page has not been completely updated for Rocky 8 yet!

The client (your desktop) computer needs X11 and the VirtualGL software:

**Linux:**

- X11 is default; if you have a graphical desktop, you have X11.
- Download your VirtualGL package from [VirtualGL](https://www.virtualgl.org/).

---

**Windows:**

- [Cygwin](https://www.cygwin.com/)
- Use the Cygwin installer to install Cygwin/X and VirtualGL.

---

**Mac:**

- [XQuartz](https://www.xquartz.org/) needs to be installed.
- Download your VirtualGL package from [VirtualGL](https://www.virtualgl.org/).

Any recent VGL client version should work (vis-node has 2.5.2). If there is no native package for your Linux distribution, you can download the .deb and unpack it using `dpkg -x virtualgl...deb vgl`. The programs you need are in `vgl/opt/VirtualGL/bin/`.

Connect to the visualization node using `vglconnect` from the VirtualGL package:

```sh
vglconnect -s uni-ID@viz.hpc.taltech.ee
```

Run the visualization application you want to use, e.g., ParaView or VisIt:

```sh
vglrun paraview
```
