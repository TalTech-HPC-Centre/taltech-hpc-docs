<span style="color:red">not changed to rocky yet</span>

# Remote visualization using Xpra

<div class="simple1">
The client (your desktop) computer needs X11 and Xpra:

-   Linux:
    -   X11 is default, if you have a graphical desktop, you have X11
    -   Xpra should be available in the package manager
-   Windows:
    -   VcXsrv or Xming or Cygwin/X
    -   Xpra client
-   Mac: 
    -   XQuarts needs to be installed ([https://www.xquartz.org/](https://www.xquartz.org/))
    -   Xpra client
</div>
<br>

Unlike [VNC](/visualization/vnc.md), these applications are "rootless". They appear as individual windows inside your window manager rather than being contained within a single window.

    xpra start ssh://uni-ID@viz.hpc.taltech.ee/ --start-child=xterm

specifying an ssh-key to use and a jump-host:

    xpra start ssh://viz/ --ssh="ssh -J base.hpc.taltech.ee" --start-child=xterm

re-attach from a different computer:

    xpra attach ssh:viz.hpc.taltech.ee

To stop Xpra, run on the server:

    xpra stop
