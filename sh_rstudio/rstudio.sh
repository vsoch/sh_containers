#!/bin/bash

# This is an example entrypoint script, intended for use on the Sherlock cluster
# The variable of interest is likely how you load singularity (e.g., module load
# and where you have space to define the cache directory. The cache directory
# should not be needed, but it's better to be safe than sorry. 
# We would submit this with a job:
#
# srun -J job-name -p dev -t 01:00:00 --qos normal --mem 4GB --x11=first --unbuffered /bin/bash rstudio.sh
# 
# and assume that we are running the commands on an interactive node. The
# container itself takes care of defining ports and printing instructions for
# the user

module load singularity/2.4.5
SINGULARITY_CACHEDIR=$SCRATCH/.singularity
export SINGULARITY_CACHEDIR
singularity run -p sh_rstudio
