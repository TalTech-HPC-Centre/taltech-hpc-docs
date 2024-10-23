if [ -v $1 ]; then
    echo "You need to pass your project as an argument to the script"
    echo "i.e: . env.sh your_project"
    return 1
fi

export PROJECT="/project/$1"
if [ ! -d $PROJECT ]; then
    echo "Project directory $PROJECT does not exist, use a active project"
    return 1
fi

export SCRATCH="/scratch/$1"
# export FLASH="/flash/$1"
# Currently /flash is not available so we bind to the alternative
export FLASH="/pfs/lustref1/flash/$1"
export SBATCH_ACCOUNT="$1"
export EBU_USER_PREFIX="$PROJECT/EasyBuild"

export SINGULARITY_TMPDIR="$SCRATCH/singularity/tmp"
export SINGULARITY_CACHEDIR="$SCRATCH/singularity/cache"