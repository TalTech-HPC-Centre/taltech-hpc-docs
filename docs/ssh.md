<span style="color:red">not changed to rocky yet</span>

# Getting SSH keys to work

<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Generationg  SSH keys 

---

In Linux and macOS SSH keys can be generated in cmd by command:
	
	ssh-keygen -t rsa
	
In Windows SSH keys can be generated in powershell by command:
	
	ssh-keygen.exe -t rsa
	
The program prompts the user through the process, just sets the location and asks the user to set a passphrase, which should be created. This process ends with two keys in the path it showed. One of them is named (by default) `id_rsa` and the other `id_rsa.pub`. The `.pub` key is your public key, the other is a private key. 

![ssh-keygen](pictures/ssh-key_1.png)

***NB! Never share your private key with anyone.***

<div class="simple1">
More detail guides can be found here:

 - Linux - [https://linuxhint.com/generate-ssh-keys-on-linux/](https://linuxhint.com/generate-ssh-keys-on-linux/)
 - macOS - [https://docs.tritondatacenter.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x](https://docs.tritondatacenter.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x)
 - Windows - [https://phoenixnap.com/kb/generate-ssh-key-windows-10](https://phoenixnap.com/kb/generate-ssh-key-windows-10)
</div>

<br>
<br>
<br>
<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Uploading SSH keys to base

---

Once the keys are created, the public (.pub) key needs to be uploaded to base. There are a couple of ways to do it. On base, SSH public keys are found in `/etc/AuthorizedKeys/$USER` file, there is a link to it from `.ssh/authorized_keys` file.

Several SSH keys can be used simultaneously to access the same user account in case of use several different devices. 

On Mac and Linux to copy keys to the cluster:

	ssh-copy-id Uni-ID@base.hpc.taltech.ee
	
![ssh-keygen](pictures/ssh-key_2.png)	
	
On windows it can be copied in powershell with this command:

	type $env:USERPROFILE\.ssh\id_rsa.pub | ssh Uni-Id@base.hpc.taltech.ee "cat >> .ssh/authorized_keys"

A more thorough explanation with an example can be found [here](https://www.chrisjhart.com/Windows-10-ssh-copy-id/).

