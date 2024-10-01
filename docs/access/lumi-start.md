# LUMI Supercomputer

!!! info
    ***If you face any problems during registration to LUMI, let us know by email at [hpcsupport@taltech.ee](mailto:hpcsupport@taltech.ee) or in Teams in the "HPC Support Chat".***

## Getting Started on LUMI

1. Log in to [minu.etais.ee](https://minu.etais.ee/login/) with MyAccessID.

    ![etais](/access/attachments/etais.png)

2. Choose your affiliation (ttu.ee).

    ![MyAccessID](/access/attachments/MyAccessID1.png)

3. Identify yourself with **Uni-ID (six letters taken from the user’s full name),** but for long time employees, it could be name.surname.

    ![etais](/access/attachments/etais-2.png)

4. Agree with all propositions and press the button to continue.

    ![etais](/access/attachments/etais-3-1.png)

5. After notification of successful account creation, **you need to open a new tab** and go to [mms.myaccessid.org](https://mms.myaccessid.org/profile/).

    ![MyAccessID](/access/attachments/MyAccessID-1.png)

    After filling in the required fields and agreeing with the use policy and terms of use, press the **"Submit"** button.

6. Register your SSH key in MyAccessID. To do this, click on `Manage SSH key`.

    ![ssh-key-1](/access/attachments/ssh-key-1.png)

    Then add your SSH key into the corresponding field. In Linux and Mac, the public SSH key can be found in the `.ssh/id_rsa.pub` file. Windows by default saves the public SSH key at `C:\Users\your_username/.ssh/id_rsa.pub`. Instructions on how to generate SSH keys can be found [here](/access/ssh).

    ![ssh-key-2](/access/attachments/ssh-key-2.png)

    It is important to add your SSH key immediately after account creation, as this SSH key will be automatically transferred to LUMI and used for user authentication during the first and subsequent connections to LUMI.

7. If **you are a project leader** -- Contact the Resource Allocator (`hpcsupport@taltech.ee`). The HPC Centre will add LUMI resources to your account. If the name of the project is already known, add it as well.  
   If **you are a team member** -- contact your project leader (or course teacher) to be added to a project.

    ***NB!*** _Just adding HPC-LUMI resources to an existing project will not work._

8. to After your you [minu.etais.ee](https://minu.etais.ee/) receive account. an answer from the HPC Centre, log in to your [minu.etais.ee](https://minu.etais.ee/) account.

9. The corresponding project appears in your ETAIS account.

    ![workspace](/access/attachments/workspace.png)

10. In a short time, you will receive a letter from `info-noreply@csc.fi` where you will be given your username for LUMI.

11. Try to connect to LUMI with the received username using the command:

    ```sh
    ssh LUMI-user-name@lumi.csc.fi
    ```

    ***NB!*** *Synchronization may take some time, so if you have problems with connection with the SSH key, wait longer and try again.*

12. Read the [LUMI documentation](https://docs.lumi-supercomputer.eu/firststeps/getstarted/). Especially check the different filesystems and their prices, since LUMI charges TB/hour, as well as the guide for containerization of Python environments (pip, conda).
