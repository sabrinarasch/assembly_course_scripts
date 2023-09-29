Sabrina Rasch (sabrina.rasch@student.unibe.ch)

# Genome and Transcriptome Assembly

This is a project of the course *Genome and Transcriptome Assembly* (473637-HS2023) of the University of Bern. It takes place in the Fall Semester 2023. The course webpage can be found [here](https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/).


Path to my project folder: **/data/users/srasch/assembly_course**

## Datasets

The datasets that are used come from:

Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics. Nature Communications. 2020;11:1–10. Available from: [http://dx.doi.org/10.1038/s41467-020-14779-y](http://dx.doi.org/10.1038/s41467-020-14779-y)

Path to data sets: **/data/courses/assembly-annotation-course/raw_data/[ACCESSION]/[DATASET]**

My data sets are: <br>
Accession: C24 <br>
Data set: 2 <br>
Illumina: ERR3624577_1.fastq.gz, ERR3624577_2.fastq.gz <br>
pacbio: ERR3415819.fastq.gz, ERR3415820.fastq.gz <br>
RNAseq: SRR1584462_1.fastq.gz, SRR1584462_2.fastq.gz

## Week 1

* Scripts: 01_01_QC.sh, 01_02_kmer.sh
* Software: fastqc 0.11.9, jellyfish 2.3.0

## Week 2

* Scripts: 02_01_flye_assembly.sh, 02_02_canu_assembly.sh, 02_03_trinity_assembly.sh
* Software: flye 2.8.3, canu 2.1.1, trinityrnaseq 2.5.1