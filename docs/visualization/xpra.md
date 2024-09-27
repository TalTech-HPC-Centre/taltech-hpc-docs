# Remote visualization using Xpra

!!! warning
    This page has not been completely updated for Rocky 8 yet!

The client (your desktop) computer needs X11 and Xpra:

**Linux:**

- X11 is default, if you have a graphical desktop, you have X11
- Xpra should be available in the package manager

---

**Windows:**

- VcXsrv or Xming or Cygwin/X
- Xpra client

---

**Mac:**

- XQuarts needs to be installed ([https://www.xquartz.org/](https://www.xquartz.org/))
- Xpra client

Unlike [VNC](/visualization/vnc), these applications are "rootless". They appear as individual windows inside your window manager rather than being contained within a single window.

```bash
xpra start ssh://uni-ID@viz.hpc.taltech.ee/ --start-child=xterm
```

Specifying an ssh-key to use and a jump-host:

```bash
xpra start ssh://viz/ --ssh="ssh -J base.hpc.taltech.ee" --start-child=xterm
```

Re-attach from a different computer:

```bash
xpra attach ssh:viz.hpc.taltech.ee
```

To stop Xpra, run on the server:

```bash
xpra stop
```
