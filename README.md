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
The goal of week 1 was to run a QC on the datasets and perform k-mer counting. For the k-mer counting a additional script was used *best_k.sh*, with the genomsize as 150'000'000, which resulted in an optimal k of 19.

* Scripts: 01_01_fastqc_QC.sh, 01_02_jellyfish_kmer.sh
* Software: fastqc 0.11.9, jellyfish 2.3.0

### Week 2 - assembly
The goal of week 2 was to generate three assemblies. Two whole genome assemblies using flye and canu and one whole transcriptome assembly using Trinity. The whole genome assemblies were done using the pacbio reads and the whole transcriptome assembly was done using the RNAseq reads.

* Scripts: 02_01_flye_assembly.sh, 02_02_canu_assembly.sh, 02_03_trinity_assembly.sh
* Software: flye 2.8.3, canu 2.1.1, trinityrnaseq 2.5.1

### Week 3 - assembly polishing and evaluation
The goal of week 3 was to improve the draft assemblies and evaluate them. The polishing of the assemblies was done using the Illumina reads. The scripts 3.1 and 3.2 were run on the unpolished assemblies from canu and flye. The evaluation was done on all assemblies. The script 3.3 was run on the unpolished assemblies from canu, flye and trinity, and the polished assemblies from canu and flye. The scripts 3.4 and 3.6 were run on the unpolished assemblies from canu and flye, and the polished assemblies from canu and flye.

* Scripts: 03_01_bowtie2_polishing.sh, 03_02_pilon_polishing.sh, 03_03_BUSCO_evaluation.sh, 03_04_QUAST_evaluation.sh, 03_05_meryl_evaluation.sh, 03_06_merqury_evaluation.sh
* Software: bowtie2 2.3.4.1, samtools 1.10, pilon 1.22, busco 4.1.4, quast 4.6.0, merqury 1.3.1

### Week 4 - comparing genomes
The goal of week 4 was to compare the assemblies from canu and flye to the *Arabidopsis thaliana* reference.

* Scripts: 04_01_nucmer_comparison.sh, 04_02_mummer_comparison.sh
* Software: mummer 4.0.0
