# Accessing SMB/CIFS network shares

!!! warning
    This page has not been completely updated for Rocky 8 yet!

---

The HPC center exports two filesystems as Windows network shares:

| Local Path on Cluster | Linux Network URL | Windows Network URL |
|-----------------------|-------------------|---------------------|
| /gpfs/mariana/smbhome/$USER | smb://smb.hpc.taltech.ee/smbhome | \\\\smb.hpc.taltech.ee\smbhome |
| /gpfs/mariana/smbgroup | smb://smb.hpc.taltech.ee/smbgroup | \\\\smb.hpc.taltech.ee\smbgroup |
| /gpfs/mariana/home/$USER | not exported | not exported |

These can be accessed from within the university or from EduVPN.

Each user automatically has a directory within smbhome. To get a directory for group access, please contact us (a group and a directory need to be created).

## Windows Access

From Windows, the shares can be found using the Explorer "Map Network Drive".

### GUI

Right-click on "This PC" and select "Add a network location" or "Map network drive".

    Server: \\smb.hpc.taltech.ee\smbhome
    Username: INTRA\<uni-id>

![win-network-drive-1](/access/attachments/networkdrive-1.png)
![win-network-drive-2](/access/attachments/networkdrive-2.png)
![win-network-drive-3](/access/attachments/networkdrive-3.png)

### PowerShell

Run the following command:

```powershell
net use \\smb.hpc.taltech.ee\smbhome /user:INTRA\<uni-id>
```

Check success with:

```powershell
get-smbconnection
```

## Linux Access

On Linux with a GUI Desktop, the shares can be accessed with the Nautilus browser.

From the Linux command line, the shares can be mounted as follows:

```bash
dbus-run-session bash
gio mount smb://smb.hpc.taltech.ee/smbhome/
```

or

```bash
dbus-run-session bash
gio mount smb://smb.hpc.taltech.ee/smbgroup/
```

You will be asked for "User" (which is your UniID), "Domain" (which is "INTRA"), and your password.

To disconnect from the share, unmount with:

```bash
gio mount -u smb://smb.hpc.taltech.ee/smbhome/
gio mount -u smb://smb.hpc.taltech.ee/smbgroup/
```

If you get "Error mounting location: Location is not mountable", then you are not in the correct network (e.g., VPN is not running), or you don't have a dbus session.

On Debian, the following packages need to be installed: `gvfs gvfs-common gvfs-daemons gvfs-fuse gvfs-libs libsmbclient gvfs-backends libglib2.0-bin`
