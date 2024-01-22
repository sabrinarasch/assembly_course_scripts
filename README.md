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
The goal of week 1 was to run a QC on the datasets and perform k-mer counting. For the k-mer counting an additional script was used *best_k.sh*, with the genomsize as 150'000'000, which resulted in an optimal k of 19.

* Scripts: 01_01_fastqc_QC.sh, 01_02_jellyfish_kmer.sh
* Software: fastqc 0.11.9, jellyfish 2.3.0
* Input:
    * 1.1: Raw reads (fastq)
    * 1.2: Raw reads (fastq)
* Output: 01_read_QC
    * 1.1: fastqc
    * 1.2: kmer

### Week 2 - assembly
The goal of week 2 was to generate three assemblies. Two whole genome assemblies using flye and canu and one whole transcriptome assembly using Trinity. The whole genome assemblies were done using the pacbio reads and the whole transcriptome assembly was done using the RNAseq reads.

* Scripts: 02_01_flye_assembly.sh, 02_02_canu_assembly.sh, 02_03_trinity_assembly.sh
* Software: flye 2.8.3, canu 2.1.1, trinityrnaseq 2.5.1
* Input:
    * 2.1: Raw reads of pacbio (fastq)
    * 2.2: Raw reads of pacbio (fastq)
    * 2.3: Raw reads of RNAseq (fastq)
* Output: 02_assembly
    * 2.1: flye
    * 2.2: canu
    * 2.3: trinity

### Week 3 - assembly polishing and evaluation
The goal of week 3 was to improve the draft assemblies and evaluate them. The polishing of the assemblies was done using the Illumina reads. The scripts 3.1 and 3.2 were run on the unpolished assemblies from canu and flye. The evaluation was done on all assemblies. The script 3.3 was run on the unpolished assemblies from canu, flye and trinity, and the polished assemblies from canu and flye. The scripts 3.4 and 3.6 were run on the unpolished assemblies from canu and flye, and the polished assemblies from canu and flye.

* Scripts: 03_01_bowtie2_polishing.sh, 03_02_pilon_polishing.sh, 03_03_BUSCO_evaluation.sh, 03_04_QUAST_evaluation.sh, 03_05_meryl_evaluation.sh, 03_06_merqury_evaluation.sh
* Software: bowtie2 2.3.4.1, samtools 1.10, pilon 1.22, busco 4.1.4, quast 4.6.0, merqury 1.3.1
* Input:
    * 3.1: Raw assembly of canu and flye (fasta)
    * 3.2: Raw assembly of canu and flye (fasta)
    * 3.3: Raw and polished assembly of canu and flye, raw assembly of trinity (fasta)
    * 3.4: Raw and polished assembly of canu and flye, reference of *Arabidopsis thaliana* genome (fasta)
    * 3.5: Raw reads of illumina (fasta)
    * 3.6: Raw and polished assembly of canu and flye (fasta), meryl file of genome (meryl)
* Output: 03_polish_evaluation
    * 3.1: polish/index; polish/align
    * 3.2: polish/pilon
    * 3.3: evaluation/BUSCO; evaluation_no_polish/BUSCO
    * 3.4: evaluation/QUAST; evaluation_no_polish/QUAST
    * 3.5: evaluation/meryl
    * 3.6: evaluation/merqury; evaluation_no_polish/merqury

### Week 4 - comparing genomes
The goal of week 4 was to compare the assemblies from canu and flye to the *Arabidopsis thaliana* reference and to each other.

* Scripts: 04_01_nucmer_comparison.sh, 04_02_mummer_comparison.sh
* Software: mummer 4.0.0
* Input:
    * 4.1: Raw assembly of canu and flye, reference of *Arabidopsis thaliana* genome (fasta)
    * 4.2: Raw assembly of canu and flye, reference of *Arabidopsis thaliana* genome (fasta), nucmer delta file (delta)
* Output: 04_comparison
    * 4.1: nucmer
    * 4.2: mummer

### Week 5 - Annotation of Transposable Elements
The goal of week 5 was to first produce a filtered non-redundant TE library for the annoation of structurally intact and fragmented elements. Then the TEs were classified according to their transposition mechanism. Class I: through an RNA intermediate ("copy/paste"). Class II: as a DNA moleculte ("cut/paste"). And further subdivision into subclasses, orderes, superfamilies, clades, and families was done.

The group decided to take the polished flye and trinity assembly of Monsur.

* Scripts: 05_01_EDTA_annotation.sh, 05_02_TE_sorter.sh, 05_03_TE_visualisation.R
* Software: EDTA 1.9.6, TEsorter 1.3.0, SeqKit 0.13.2, R 4.3.0
* Input:
    * 5.1: polished assembly flye, (TAIR10_cds_20110103_representative_gene_model_updated)
    * 5.2: polished.fasta.mod.EDTA.TElib.fa (output of EDTA), Brassicaceae_repbase_all_march2019.fasta
    * 5.3: polished.fasta.mod.EDTA.TEanno.gff3 (output of EDTA)
* Output: 05_TE_annotation
    * 5.1: TE_annotator
    * 5.2: TE_sorter
    * 5.3: TEs_by_Clades_and_Range_contig_10_pilon.pdf
* Container
    * 5.1:
        * singularity
        * /data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif
    * 5.2:
        * singularity
        * /data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif

### Week 6 - Dynamics of Transposable elements
The goal of week 6 was to estimate the age of TEs (time of insertion), which can be estimated by calculating the divergence to a consensus sequence. The assumption behind this is, that copies of the same family derive from one common active element and therefore they need to be identical at the time of insertion and then accumulate mutations over time. Further phylogenetic relations between TEs was analysed. This allows to defined groups of closely related TEs that come from a common ancestral TE sequence. Most such studies analyse well characterised protein coding sequences, such as the reverse transcriptase, ribonuclease H and integrase for LTR retrotransposons, and transposase for DNA transposons. This analysis is done on the retrotransposon superfamilies copia and gypsy.

* Scripts: 06_01_TE_dating.sh, 06_02_TE_dating_plot_div.R
* Software: R 4.3.0, SeqKit 0.13.2, clustal-omega 1.2.4, FastTree 2.1.10
* Input:
    * 6.1: polished.fasta.mod.out (output of EDTA)
    * 6.2: polished.fasta.sed.tab (output of 6.1)
    * 6.3: *dom.faa (output of 5.2) of both families
* Output: 06_TE_dynamics
    * 6.1: TE_dating
    * 6.2: TE-myr_lines.pdf, TE-myr.pdf
    * 6.3: TE_phylogeny
* Container
    * 6.1:
        * conda create -n assembly_course_environment
        * conda install -c bioconda perl-bioperl

### Week 7 - Annotation of protein-coding sequences
The goal of week 7 was to annotate the genome and create a genome database. The MAKER pipeline was used for this task. It automatically compiles 1. *ab initio* prediction models, 2. evidence of expression and 3. sequence homolgy to known proteins, into gene annotations.

* Scripts: 07_01_prot_annotation.sh, 07_02_gff_fasta_annotation.sh
* Software: maker 2.31.9
* Input:
    * 7.1: polished flye assembly and trinity assembly
    * 7.2: polished_master_datastore_index.log (output of maker)
* Output: 07_prot_annotation
    * 7.1: polished.maker.output
    * 7.2: polished.maker.output.renamed
* Container
    * 7.1:
        * singularity
        * /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif

### Week 8 - Assess annotation quality
The goal of week 8 was to assess the annotation quality. The completeness of the annotation was analysed using BUSCO. Further the sequence homology to functionally validated proteins was analysed. This was done using the UniProt database.

* Scripts: 08_01_BUSCO_evaluation.sh, 08_02_UniProt_evaluation.sh
* Software: busco 4.1.4, ncbi-blast 2.10.1+
* Input:
    * 8.1 & 8.2: polished.all.maker.proteins.fasta.renamed.fasta (output of maker then processed with script 07_02_gff_fasta_annotation.sh)
* Output: 08_Quality
    * 8.1: BUSCO
    * 8.2: UniProt

### Week 9 - Comparative genomics
The goal of week 9 was to study the sequence homology to proteins of closely related species with comparative genomics. A group of genes that descend from a single gene in the last common ancestor of different species is called an orthogroup. Visualising the percentages of genes in orthogroups helps with quality control. Normally, a high percentage of such genes is expected, but if a distant species is present in the proteomic data used, this is not the case.

* Scripts: 09_01_bed_fasta_formatting.sh, 09_02_genespace.sh, 09_03_Parse_Orthofinder.R
* Software: SeqKit 0.13.2, R 4.3.0
* Input:
    * 9.1: *.all.maker.noseq.gff.renamed.gff, *.all.maker.proteins.fasta.renamed.fasta
    * 9.2: bed, peptide, noseq, proteins
    * 9.3: Statistics_PerSpecies.tsv
* Output: 09_comp_genomics
    * 9.1: bed, peptide
    * 9.2: genespace
    * 9.3: Orthofinder
* Container
    * 9.2:
        * apptainer
        * /data/users/srasch/assembly_course/scripts/genespace_1.1.4.sif (from Giliane Rochat)
