# Getting SSH keys to work

!!! warning
    This page has not been completely updated for Rocky 8 yet!

## Generating SSH keys

In Linux and macOS SSH keys can be generated in the terminal with the command:

```sh
ssh-keygen -t rsa
```

In Windows SSH keys can be generated in PowerShell with the command:

```sh
ssh-keygen.exe -t rsa
```

The program prompts the user through the process, setting the location and asking the user to set a passphrase, which should be created. This process ends with two keys in the path it showed. One of them is named (by default) `id_rsa` and the other `id_rsa.pub`. The `.pub` key is your public key, the other is a private key.

![ssh-keygen](/access/attachments/ssh-key_1.png)

**Note: Never share your private key with anyone.**

More detailed guides can be found here:

- Linux - [https://linuxhint.com/generate-ssh-keys-on-linux/](https://linuxhint.com/generate-ssh-keys-on-linux/)
- macOS - [https://docs.tritondatacenter.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x](https://docs.tritondatacenter.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x)
- Windows - [https://phoenixnap.com/kb/generate-ssh-key-windows-10](https://phoenixnap.com/kb/generate-ssh-key-windows-10)

---

## Uploading SSH keys to base

Once the keys are created, the public (.pub) key needs to be uploaded to the base. There are a couple of ways to do it. On the base, SSH public keys are found in the `/etc/AuthorizedKeys/$USER` file, and there is a link to it from the `.ssh/authorized_keys` file.

Several SSH keys can be used simultaneously to access the same user account in case of using several different devices.

On Mac and Linux, to copy keys to the cluster:

```sh
ssh-copy-id Uni-ID@base.hpc.taltech.ee
```

![ssh-keygen](/access/attachments/ssh-key_2.png)

On Windows, it can be copied in PowerShell with this command:

```sh
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh Uni-Id@base.hpc.taltech.ee "cat >> .ssh/authorized_keys"
```

A more thorough explanation with an example can be found [here](https://www.chrisjhart.com/Windows-10-ssh-copy-id/).
