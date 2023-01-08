# assemble contigs providing evidence for integration sites that have been identified using MANTA
# load modules to be required
module purge
module load build-env/.f2021
module load samtools/1.14-gcc-10.2.0
module load bwa/0.7.17-gcc-10.2.0
module load samblaster/0.1.26-gcc-10.2.0
module load bedtools/2.30.0-gcc-10.2.0

# create genome contig index
bwa index fusion.fa fusion

# sort evidence file by name
samtools sort -n evidence_sorted_dedup.bam -o evidence_sorted_dedup.sorted.bam

# convert bam to fastq
bedtools bamtofastq -i evidence_sorted_dedup.sorted.bam -fq output_r1.fastq -fq2 output_r2.fastq

# align reads to contig
bwa mem -R "@RG\tID:id\tSM:sample\tLB:lib" sample.fa output_r1.fastq output_r2.fastq     | samblaster --excludeDups --addMateTags --maxSplitCount 2 --minNonOverlap 20     | samtools view -S -b -     > fusion.bam

# sort bam by coordinates
cat fusion.bam | samtools sort -o fusion.coord.sorted.bam -

# create index
samtools index fusion.coord.sorted.bam