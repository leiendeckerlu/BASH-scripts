#!/usr/bin/env bash

#SBATCH --job-name=manta_config
#SBATCH --cpus-per-task=1
#SBATCH --qos=short
#SBATCH--output=multithread-%j.out

##SBATCH --time=00-01:00:00 # one day
##SBATCH --mem=32G   #64GB of RAM

# env
export PATH=/Software/manta-1.6.0.centos6_x86_64/bin/:$PATH

module load python/2.7.15-foss-2018b

###

python /Software/manta-1.6.0.centos6_x86_64/bin/configManta.py \
--tumorBam sample_sorted_dedup.bam \
--referenceFasta ../references/genome.fa \
--exome \
--callRegions ../references/manta_target_regions_hg38.bed.gz \
--generateEvidenceBam \
--outputContig \
--runDir ./sample/
