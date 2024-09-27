#!/bin/bash
#SBATCH --job-name=WAM-testrun
#SBATCH --mem-per-cpu=1GB
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH -t 0-01:0:00
#SBATCH --partition=green-ib
#SBATCH --no-requeue

module load green/all
module load WAM

    export WORK=$HOME/newwamtest
    export LOGDIR=$WORK/wamlogs
    
    mkdir --parent ${WORK}/tempsg
    mkdir --parent ${WORK}/work
    mkdir --parent ${LOGDIR}/dayfiles

    cd ${WORK}/tempsg
    cp ${WAMDIR}/const/TOPOCAT.DAT .
    cp ${WAMDIR}/const/Coarse_Grid/ARD/Preproc_User .
    preproc

    #mv Preproc_Prot ${LOGDIR}/dayfiles/preproc_prot_coarse_ARD
    #mv Grid_info_COARSE_GRID ../work/
    #rm Preproc_User TOPOCAT.DAT

    mkdir --parent $WORK/coarse/ARD

    cp ${WAMDIR}/const/Coarse_Grid/ARD/WAM_User .
    cp ${WAMDIR}/const/WIND_INPUT.DAT .
    mpirun wam
    #cp logfile.0 ${LOGDIR}/dayfiles/wam_prot_coarse_ARD
    #mv BLS* MAP* OUT* C* ../coarse/ARD
    #rm WAM_User Grid_info_COARSE_GRID WIND_INPUT.DAT

    cp ${WAMDIR}/const/Coarse_Grid/ARD/Grid_User .
    pgrid
    #mv Grid_Prot ${LOGDIR}/dayfiles/pgrid_prot_coarse_ARD
    #rm Grid_User

    cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User .
    ptime
    #mv Time_Prot ${LOGDIR}/dayfiles/ptime_prot_coarse_ARD
    #rm Time_User

    cp ${WAMDIR}/const/Coarse_Grid/ARD/Spectra_User .
    pspec
    #mv Spectra_Prot ${LOGDIR}/dayfiles/pspec_prot_coarse_ARD
    #rm Spectra_User

    cp ${WAMDIR}/const/Coarse_Grid/ARD/Time_User_S .
    ptime_S
    #mv Time_Prot_S ${LOGDIR}/dayfiles/ptime_S_prot_coarse
    #rm Time_User_S

    cp ${WAMDIR}/const/Coarse_Grid/ARD/nlnetcdf NETCDF_User
    mpirun ./pnetcdf.exe
    #mv pnetcdf_prot ${LOGDIR}/dayfiles/pnetcdf_prot_coarse_ARD
    #mv WAVE* ../coarse/ARD
    #rm NETCDF_User
