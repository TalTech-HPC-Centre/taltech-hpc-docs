# Remote visualization using X2GO (easiest to get working)

!!! warning
    This page has not been completely updated for Rocky 8 yet!

The client (your desktop) computer needs the [X2GO-client](https://www.x2go.org)

**NB!** _X2GO uses ssh-key. Ssh-key generation guide is [here](/access/ssh)._

**NB!** _To use **viz** the ssh-key must be added to the **base** node._

On Mac and Linux this can be done by command:

```sh
ssh-copy-id Uni-ID@base.hpc.taltech.ee
```

After about an hour, when the automatic script has synced the files, you can use **viz**.

---

## Configuring the client

During first use, X2GO-client needs to be configured as shown in the picture. To configure, select the "Session" tab in the upper left corner.
The setting of the ssh-key is only necessary if you use a non-standard name or not the default key.

![Configuration](/visualization/attachments/x2go-config-1.png)

Large memory-consuming Desktop environments like MATE, KDE, GNOME are **not** available. Use window managers like `blackbox`, `fluxbox`, `jwm`, `fvwm2`, `awesome`, `lwm`, `fvwm-crystal` (last setting on the screen).

If you select `Terminal` as "Session type" (use "fvwm2" as Command), you will get a "rootless" xterm and you can use that to start other software which will appear as individual windows on your regular desktop (not within a remote desktop window).

It is also recommended to configure the display settings, for example, as done in the example below or in some other suitable way, since changing the resolution of the remote desktop (= window size) at runtime is not possible (resizing the window would be the equivalent of stretching your physical monitor) or can have other undesired effects.

![Configuration](/visualization/attachments/x2go-config-2.png)

---

## Configuring the server-side

A couple of config files need to be present:

- `$HOME/.fvwm/.fvwm2rc` [.fvwm2rc](/visualization/attachments/fvwm2rc.fvwm2rc)
- `$HOME/.xsessionrc-x2go` [.xsessionrc-x2go](/visualization/attachments/xsessionrc-x2go.xsessionrc-x2go) (can be a link to .xsessionrc, .xsession, or .vnc/xstartup)

If the files are not present, just **copy them from** `/etc/skel/` or put:

- [.fvwm2rc](/visualization/attachments/fvwm2rc.fvwm2rc) to `$HOME/.fvwm/.fvwm2rc`
- [.xsessionrc-x2go](/visualization/attachments/xsessionrc-x2go.xsessionrc-x2go) to `$HOME/.xsessionrc-x2go`

to copy/save the example configs.

---

## X2GO usage

`$HOME` on **base** coincides with `$HOME` on **viz**.

When the session is configured, press `enter` to run the session. Press the left bottom of the mouse to call the menu and choose XTerm.

![XTerm](/visualization/attachments/XTerm.png)

A terminal will appear where the user can call the desired visualization program. We do *not* maintain the list of software in the menus of window managers or desktop environments, which means even with a graphical frontend, you still need to use the command-line to start your programs! You can configure the menus yourself, e.g., in the `$HOME/.fvwm/.fvwm2rc` file for the fvwm window manager.

**Viz** has a module system. Most of the modules need to be loaded unless the manual says they are native.

Before loading modules, the source must be specified:

```sh
source /usr/share/lmod/6.6/init/bash
module use /gpfs/mariana/modules/system
```

followed by module load commands, for example:

```sh
module load viz-spack
module load jmol
```

![x2go-jmol](/visualization/attachments/x2go-jmol.png)

In the case of a native program, only the command that calls this program is needed.

```sh
rasmol
```

or

```sh
paraview
```

**NB!** _ParaView and maybe other software using GLX need to be started using VirtualGL: `vglrun paraview`_

![x2go-awesome](/visualization/attachments/x2go-awesome.png)

---

## Terminating X2GO

It is extremely important to end the session properly! To do this:

1. Print `exit` in your terminal
2. Click the left mouse button, call the menu, and choose `Exit fvwm`.

![exit](/visualization/attachments/x2go-exit.png)
