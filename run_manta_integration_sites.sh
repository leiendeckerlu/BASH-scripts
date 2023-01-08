#!/usr/bin/env bash

#SBATCH --job-name=run_manta
#SBATCH --cpus-per-task=12
#SBATCH --qos=short
#SBATCH--output=multithread-%j.out

##SBATCH --time=00-12:00:00 # one day
##SBATCH --mem=16G   #64GB of RAM

# env
export PATH=/Software/manta-1.6.0.centos6_x86_64/bin/:$PATH

module load python/2.7.15-foss-2018b

python runWorkflow.py -m local -j 12
