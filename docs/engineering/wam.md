<span style="color:red">not changed to rocky yet</span>

# WAM Cycle 6

WAM is a third-generation wave model that describes the evolution of the wave spectrum by solving the wave energy transfer equation. WAM predicts wave direction spectra and properties and can be linked to a number of other models.

A repository of the source code with modifications for Taltech HPC, can be found [here](https://gitlab.cs.ttu.ee/heiko.herrmann/wam-cycle_6-TalTech-HPC).

<span style="font-size:20px"><b>
How to cite </b>
</span> 
<br>

The WAM Model—A Third Generation Ocean Wave Prediction Model DOI: [https://doi.org/10.1175/1520-0485(1988)018<1775:TWMTGO>2.0.CO;2](https://journals.ametsoc.org/view/journals/phoc/18/12/1520-0485_1988_018_1775_twmtgo_2_0_co_2.xml)
<br>
<hr style="margin: 4px 0px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## Quickstart 

---

### Short jobs & one core jobs

1. To run your first calculations, start a session on a node:

		srun -t 2:0:0 --pty bash

2. Enter the following commands to set up environment and working directory:
   
        module load green/all
    	module load WAM

    	export WORK=$HOME/newwamtest
    
    	mkdir --parent ${WORK}/tempsg
    
    	cd ${WORK}/tempsg
    	cp ${WAMDIR}/const/TOPOCAT.DAT .
    	cp ${WAMDIR}/const/Coarse_Grid/ARD/Preproc_User .
    	preproc
    
    	cp ${WAMDIR}/const/Coarse_Grid/ARD/WAM_User .
    	cp ${WAMDIR}/const/WIND_INPUT.DAT .

3. Run WAM

	    mpirun wam

	    cp ${WAMDIR}/const/Coarse_Grid/ARD/Grid_User .
	    pgrid
    
	    cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User .
	    ptime
    
	    cp ${WAMDIR}/const/Coarse_Grid/ARD/Spectra_User .
	    pspec
    
	    cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User_S .
	    ptime_S
    
	    cp ${WAMDIR}/const/Coarse_Grid/ARD/nlnetcdf NETCDF_User
	    mpirun pnetcdf
	

4. Adapt the WORKDIR, LOGDIR and output directories to your needs!

5. If calculations are going normally, you should have the following files in your `$WORK` directory:

		BLS19780907060000  Grid_Prot              OUT19780907060000  Time_Prot_S
		BLS19780908060000  Grid_User              OUT19780908060000  Time_User
		C0119780906060000  Grid_info_COARSE_GRID  Preproc_Prot       Time_User_S
		C0119780907060000  MAP19780906060000      Preproc_User       WAM_Prot
		C0119780908060000  MAP19780907060000      Spectra_Prot       WAM_User
		C0219780906060000  MAP19780908060000      Spectra_User       WAVE1978090606.nc
		C0219780907060000  NETCDF_User            TOPOCAT.DAT        WIND_INPUT.DAT
		C0219780908060000  OUT19780906060000      Time_Prot          pnetcdf_prot

6. To visualise results you can open the `WAVE*.nc` file for example in Octave or Matlab.

    	pkg load netcdf
    	netcdf_open('WAVE1978090606.nc')
    	ncdisp('WAVE1978090606.nc')
    	hmax = ncread("WAVE1978090606.nc",'hmax_st')
    	%plot field at timestep 12
    	pcolor(hmax(:,:,12))
    
    	hs_swell = ncread("WAVE1978090606.nc",'hs_swell')
    	%plot timeseries at position 20 20
    	plot(hs_swell(20,20,:))


### Long & parallel jobs

Longer running and parallel jobs are better submitted as batch jobs using an sbatch script [wam.slurm](wam.slurm):

<details><summary>Click to expand</summary>

    #!/bin/bash
    #SBATCH --job-name=WAM-testrun
    #SBATCH --mem-per-cpu=1GB
    #SBATCH --nodes=1
    #SBATCH --ntasks=2
    #SBATCH --cpus-per-task=1
    #SBATCH -t 0-01:0:00
    #SBATCH --partition=green-ib
    #SBATCH --no-requeue

    module load green
    module load WAM

    export WORK=$HOME/newwamtest
    
    mkdir --parent ${WORK}/tempsg
    mkdir --parent ${WORK}/work
    
    cd ${WORK}/tempsg
    cp ${WAMDIR}/const/TOPOCAT.DAT .
    cp ${WAMDIR}/const/Coarse_Grid/ARD/Preproc_User .
    preproc
    
    cp ${WAMDIR}/const/Coarse_Grid/ARD/WAM_User .
    cp ${WAMDIR}/const/WIND_INPUT.DAT .

    mpirun wam

    cp ${WAMDIR}/const/Coarse_Grid/ARD/Grid_User .
    pgrid
    
    cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User .
    ptime
    
    cp ${WAMDIR}/const/Coarse_Grid/ARD/Spectra_User .
    pspec
    
    cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User_S .
    ptime_S
    
    cp ${WAMDIR}/const/Coarse_Grid/ARD/nlnetcdf NETCDF_User
    mpirun pnetcdf
</details>
<br/>


<hr style="margin: 4px 0px; border:2px solid  #d9d9d9 "></hr>
<hr style="margin: 4px 0px; border:1px solid  #d9d9d9 "></hr>

## WAM long version

---

### Starting calculations

If job is small it can be run as an interactive session:

	srun -t 2:0:0 --pty bash

If calculation is long or needs several cores, it is better to gather all needed commands in one [wam.slurm](wam.slurm) batch script and submit it by command:

	sbatch wam.slurm

### Preparation

1. Firstly, user needs to load proper environment by commands:

		module load green
		module load WAM

2. After it is needed to determine working directory and go into it 

		export WORK=$HOME/newwamtest
		mkdir --parent ${WORK}/tempsg
		cd ${WORK}/tempsg

3. Copy into working directory all needed data, for example:

		cp ${WAMDIR}/const/TOPOCAT.DAT .
		cp ${WAMDIR}/const/Coarse_Grid/ARD/Preproc_User .
		preproc
    
		cp ${WAMDIR}/const/Coarse_Grid/ARD/WAM_User .
		cp ${WAMDIR}/const/WIND_INPUT.DAT .

### Running WAM

WAM calculations can be started by command `WAM`.

	mpirun wam

To run calculations normally, such parameters as grid (`pgrid`), time (`ptime`), spectra (`pspec`) time step (`ptime_S`) and (`pnetcdf`) should be defined or copy from example:

	cp ${WAMDIR}/const/Coarse_Grid/ARD/Grid_User .
	pgrid
    
	cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User .
	ptime
    
	cp ${WAMDIR}/const/Coarse_Grid/ARD/Spectra_User .
	pspec
    
	cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User_S .
	ptime_S
    
	cp ${WAMDIR}/const/Coarse_Grid/ARD/nlnetcdf NETCDF_User
	mpirun pnetcdf

If calculations are going normally, you should have the following files in your `$WORK` directory:

	BLS19780907060000  Grid_Prot              OUT19780907060000  Time_Prot_S
	BLS19780908060000  Grid_User              OUT19780908060000  Time_User
	C0119780906060000  Grid_info_COARSE_GRID  Preproc_Prot       Time_User_S
	C0119780907060000  MAP19780906060000      Preproc_User       WAM_Prot
	C0119780908060000  MAP19780907060000      Spectra_Prot       WAM_User
	C0219780906060000  MAP19780908060000      Spectra_User       WAVE1978090606.nc
	C0219780907060000  NETCDF_User            TOPOCAT.DAT        WIND_INPUT.DAT
	C0219780908060000  OUT19780906060000      Time_Prot          pnetcdf_prot


### Visualisation

To visualise results you can open the `WAVE*.nc` file for example in Octave or Matlab

    	pkg load netcdf
    	netcdf_open('WAVE1978090606.nc')
    	ncdisp('WAVE1978090606.nc')
    	hmax = ncread("WAVE1978090606.nc",'hmax_st')
    	%plot field at timestep 12
    	pcolor(hmax(:,:,12))
    
    	hs_swell = ncread("WAVE1978090606.nc",'hs_swell')
    	%plot timeseries at position 20 20
    	plot(hs_swell(20,20,:))


