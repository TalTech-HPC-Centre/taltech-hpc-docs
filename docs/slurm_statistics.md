<span style="color:red">not changed to rocky yet</span>

<hr style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: -24px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

### SLURM finished job statistics

---

A statistics file is created after finishing a job which shows hardware and job related info to the user. Statistics files are separated by the ID of the job and the filename is generated as such using the SLURM environment variable allocated to the job as the ID: `slurm-$SLURM_JOB_ID.stat`. The `.stat` file created in the user’s current working directory where the job is run. 

<div class="simple2">
The statistics file contains:

-   JobID
-   The state of the job upon completion
-   Nodelist
-   Cores per node
-   CPU Utilized (This figure represents the time that the CPUs were used.)
-   CPU Efficiency (Represents the percentage that the CPUs were used versus the overall runtime of the job.)
-   Job Wall-clock time (The duration of the job.)
-   Memory Utilized (Total amount of memory utilized in kilobytes)
-   Memory Efficiency (Percentage of total memory allocated)
-   MaxDiskWrite (Displays disk usage)
-   Command (Displays the command that was run for this job, makes it easier for users to identify where an error might have occurred). This info may be used to better allocate resources depending on the job or modify the job scripts so that they use the allocated resources more efficiently.
</div>

Disabling this feature:
Create the file `.no_slurm_stat` by running the command
`touch ~/.no_slurm_stat`.

To re-enable this feature simply remove the `.no_slurm_stat` by running the command
`rm ~/.no_slurm_stat`.

