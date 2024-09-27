# SLURM finished job statistics

!!! warning
    This page has not been completely updated for Rocky 8 yet!

---

A statistics file is created after finishing a job which shows hardware and job related info to the user. Statistics files are separated by the ID of the job and the filename is generated as such using the SLURM environment variable allocated to the job as the ID: `slurm-$SLURM_JOB_ID.stat`. The `.stat` file created in the user’s current working directory where the job is run.

The statistics file contains:

- JobID
- The state of the job upon completion
- Nodelist
- Cores per node
- CPU Utilized (This figure represents the time that the CPUs were used.)
- CPU Efficiency (Represents the percentage that the CPUs were used versus the overall runtime of the job.)
- Job Wall-clock time (The duration of the job.)
- Memory Utilized (Total amount of memory utilized in kilobytes)
- Memory Efficiency (Percentage of total memory allocated)
- MaxDiskWrite (Displays disk usage)
- Command (Displays the command that was run for this job, makes it easier for users to identify where an error might have occurred). This info may be used to better allocate resources depending on the job or modify the job scripts so that they use the allocated resources more efficiently.

Disabling this feature:
Create the file `.no_slurm_stat` by running the command
`touch ~/.no_slurm_stat`.

To re-enable this feature simply remove the `.no_slurm_stat` by running the following command: `rm ~/.no_slurm_stat`
