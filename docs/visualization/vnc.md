# Remote visualization using VNC

!!! warning
    This page has not been completely updated for Rocky 8 yet!

---

## Short guide

1. Connect to **viz**:

    ```sh
    ssh uni-ID@viz.hpc.taltech.ee
    ```

2. Start VNC on **viz** by command:

    ```sh
    vncserver -geometry 1265x980
    ```

3. Open a second connection to **viz**:

    ```sh
    ssh -L 59XX:localhost:50XX uni-ID@viz.hpc.taltech.ee
    ```

    where `XX` is the display number that appears after giving the `vncserver` command.
    **NB!** _`XX` is always the number of two digits (e.g. `01` for `:1`)_

4. On your desktop start a vncviewer

    ```sh
    vncviewer :XX
    ```

    where `XX` is the display number

5. **Stop the vncserver!!!** on **viz** by command:

    ```sh
    vncserver -kill :XX
    ```

---

## Get started

### Software recommended to use

Virtual Network Computing (VNC) is a graphical desktop-sharing system to remotely control another computer.

The client (your desktop) computer needs a vncviewer:

- **Linux:** [xtigervncviewer](https://command-not-found.com/xtigervncviewer)
- **Windows:** TigerVNCviewer: [vncviewer64-1.12.0.exe](https://sourceforge.net/projects/tigervnc/files/stable/1.12.0/vncviewer64-1.12.0.exe/download)
- **Mac:** [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/)

### First time use

On the first start, VNC asks to specify a password to connect to the server. Choose a secure one, which does not match your HPC/UniID password because VNC connections are not encrypted!

![vnc-host-0](/visualization/attachments/vnc-host-0.png)

---

## VNC Long version

VNC should be run firstly at **viz** node of HPC and after at the user's computer.

1. Connect to **viz** by command:

    ```sh
    ssh uni-ID@viz.hpc.taltech.ee
    ```

    If this command does not work, try to connect through jump host:

    ```sh
    ssh -J uni-ID@base.hpc.taltech.ee uni-ID@viz 
    ```

    **NB!** _Connection to **viz** can be done **only** with SSH keys. SSH key generation guide is [here](/access/ssh)._

    **NB!** _To use **viz** the SSH key must be added to the **base** node._

    On Mac and Linux this can be done by command:

    ```sh
    ssh-copy-id Uni-ID@base.hpc.taltech.ee
    ```

    After about an hour, when the automatic script has synced the files, you can use **viz**.

2. On **viz** start the VNC server. Depending on which VNC client user has, one of those commands should be given:

    ```sh
    vncserver -geometry 1265x980
    ```

    and for Tiger VNC:

    ```sh
    tigervncserver -geometry 1280x1024
    ```

    It is recommended to specify window size as well by `-geometry` flag, since changing the resolution of the remote desktop (= window size) at runtime can have undesired effects.

3. The output in the terminal will show on which display VNC is running.

    ![vnc-host-1](/visualization/attachments/vnc-host-1.png)

    See the second line `desktop at :8`, where `:8` is the display number -- further `XX`.

4. Open a second connection to **viz** (in a new terminal) and give the command:

    ```sh
    ssh -L 59XX:localhost:50XX uni-ID@viz.hpc.taltech.ee
    ```

    where `XX` is the display number as two digits (e.g. `01` for `:1`)

    **NB!** _If you were connected through jump host this command should be given:_

    ```sh
    ssh -J Uni-ID@base.hpc.taltech.ee -L 59XX:127.0.0.1:59XX Uni-ID@viz
    ```

5. On **your desktop** start a VNC viewer. If you do it from the terminal, give one of these commands depending on which VNC viewer you have:

    ```sh
    vncviewer :XX
    ```

    or

    ```sh
    xtigervncviewer localhost:XX
    ```

    where `XX` is the number from above. On Windows (depending on the VNC-client) the address to connect to could be `localhost::50XX` (again, the `XX` stands for the display/port as specified before).

    If you use a graphical interface, specify localhost in the corresponding field (line at the top) and click the "Continue" button.

    ![vnc-1](/visualization/attachments/vnc-1.png)

    Type password.

    ![vnc-2](/visualization/attachments/vnc-2.png)

    If you see a monochromic field and cannot start a session, it means that you need to set up your VNC session: [Setting up VNC config](#setting-up-vnc-session).

    If you see a terminal, then everything is done correctly and you can start working. Within the session window, you can start any program from the terminal or using the menus of the window manager.

    **Viz** has a module system. Most of the modules need to be loaded unless the manual says they are native.

    Before loading modules, the source must be specified:

    ```sh
    source /usr/share/lmod/6.6/init/bash
    module use /gpfs/mariana/modules/system
    ```

    followed by two commands to load the modules. The first one loads **viz-spack** or **viz module**, depending on the program installation type, and the second command loads the program itself. For example:

    ```sh
    module load viz-spack
    module load jmol
    ```

    ![vnc-3](/visualization/attachments/vnc-3.png)

    In the case of a native program, only the command that calls this program is needed.

    ```sh
    rasmol
    ```

    or

    ```sh
    paraview
    ```

---

## Correct termination

It is very important to finish the session correctly! If you do not do it, the session continues to run even if you close the session on your computer.

To stop the VNC session, give on **viz** one of these commands:

```sh
vncserver -kill :XX
```

or

```sh
tigervncserver -kill :XX
```

where `XX` is the display number.

Running sessions can be checked by command:

```sh
vncserver -list
```

![vnc-4](/visualization/attachments/vnc-4.png)

---

## Setting up VNC session

It is impossible to work with VNC without setting it up. To do this, give the following commands from the home directory on **base** or **viz**:

```sh
cat <<EOT > .xsession
xterm &
fvwm2
EOT
```

This will configure the automatic startup of `xterm` and `fvwm2` window manager. Alternatively, the user can use other window managers: more desktop-like -- `fluxbox`, `awesome` or `jwm` or tiling -- `i3`, `xmonad` or `tritium`. To do this, the corresponding line must be added to the `.xsession` file by command:

```sh
echo "fluxbox" >> .xsession
```

The same way `.vnc/xstartup` can be configured in case the user wants to apply special settings exactly to VNC visualization.
