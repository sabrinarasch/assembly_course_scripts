Sabrina Rasch (sabrina.rasch@student.unibe.ch)

# Genome and Transcriptome Assembly

This is a project of the course *Genome and Transcriptome Assembly* (473637-HS2023) of the University of Bern. It takes place in the Fall Semester 2023. The course webpage can be found [here](https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/).


Path to my project folder on the IBU cluster: **/data/users/srasch/assembly_course**

## Datasets

The datasets that are used come from:

Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics. Nature Communications. 2020;11:1–10. Available from: [http://dx.doi.org/10.1038/s41467-020-14779-y](http://dx.doi.org/10.1038/s41467-020-14779-y)

### My datasets

* Accession: C24
* Data set: 2
* Illumina: ERR3624577_1.fastq.gz, ERR3624577_2.fastq.gz
* pacbio: ERR3415819.fastq.gz, ERR3415820.fastq.gz
* RNAseq: SRR1584462_1.fastq.gz, SRR1584462_2.fastq.gz

Path to data sets on the IBU cluster: **/data/courses/assembly-annotation-course/raw_data/[ACCESSION]/[DATASET]**

## Roadmap

### Week 1 - reads & QC
* Scripts: 01_01_fastqc_QC.sh, 01_02_jellyfish_kmer.sh
* Software: fastqc 0.11.9, jellyfish 2.3.0

### Week 2 - assembly
* Scripts: 02_01_flye_assembly.sh, 02_02_canu_assembly.sh, 02_03_trinity_assembly.sh
* Software: flye 2.8.3, canu 2.1.1, trinityrnaseq 2.5.1

### Week 3 - assembly polishing and evaluation
* Scripts: 03_01_bowtie2_polishing.sh, 03_02_pilon_polishing.sh, 03_03_BUSCO_evaluation.sh, 03_04_QUAST_evaluation.sh, 03_05_meryl_evaluation.sh, 03_06_merqury_evaluation.sh
* Software: bowtie2 2.3.4.1, samtools 1.10, pilon 1.22, busco 4.1.4, quast 4.6.0, meryl (canu 2.1.1), merqury 1.3.1
* Run script 3.1 and 3.2 on unpolished assembly of canu and flye
* Run script 3.3 on  unpolished assembly of canu, flye and trinity, and polished assembly of canu and flye
* Run script 3.4, 3.6 on unpolished assembly of canu and flye and polished assembly of canu and flye

### Week 4 - comparing genomes
* Scripts: 
* Software: 
