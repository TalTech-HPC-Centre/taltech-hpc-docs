<span style="color:red">not changed to rocky yet</span>

# Remote visualization using VirtualGL

<div class="simple1">
The client (your desktop) computer needs X11 and the VirtualGL software:

-   Linux: 
    -   X11 is default, if you have a graphical desktop, you have X11
    -   download your VirtualGl package from <https://www.virtualgl.org/>
-   Windows:
    -   Cygwin <https://www.cygwin.com/>
    -   use the Cygwin installer to install Cygwin/x and VirtualGL
-   Mac: 
    -   XQuarts needs to be installed <https://www.xquartz.org/>
    -   download your VirtualGl package from <https://www.virtualgl.org/>
</div>
<br>

Any recent VGL client version should work (vis-node has 2.5.2). If there is no native package for your Linux distribution, you can download the .deb and unpack it using `dpkg -x virtualgl...deb vgl`. The programs you need are in `vgl/opt/VirtualGL/bin/`.

Connect to the visualization node using `vglconnect` from the VirtualGL package

    vglconnect -s uni-ID@viz.hpc.taltech.ee

and run the visualization application you want to use, e.g. ParaView or VisIt:

    vglrun paraview

