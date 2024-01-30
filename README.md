Sabrina Rasch (sabrina.rasch@student.unibe.ch)

# Genome and Transcriptome Assembly

This is a project of the course *Genome and Transcriptome Assembly* (473637-HS2023) of the University of Bern. It takes place in the Fall Semester 2023. The course webpage can be found [here](https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/).


Path to my project folder on the IBU cluster: **/data/users/srasch/assembly_course**

## Datasets

The data set used for the analysis come from:

Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple Arabidopsis genomes reveal hotspots of rearrangements with altered evolutionary dynamics. Nature Communications. 2020;11:1–10. Available from: [http://dx.doi.org/10.1038/s41467-020-14779-y](http://dx.doi.org/10.1038/s41467-020-14779-y)

### My datasets
The group that analysed the accession C24 consists of Pascal Amrein, Lea Brönniman, Mansour Faye, Sabrina Rasch, and Zhihui Wang. In this analysis data set 2 was examined, the associated files are:
* Whole genome Illumina: ERR3624577_1.fastq.gz, ERR3624577_2.fastq.gz
* Whole genome pacbio: ERR3415819.fastq.gz, ERR3415820.fastq.gz
* Whole transcriptome Illumiina RNAseq: SRR1584462_1.fastq.gz, SRR1584462_2.fastq.gz

Path to data sets on the IBU cluster: **/data/courses/assembly-annotation-course/raw_data/[ACCESSION]/[DATASET]**

## Roadmap

### Week 1 - reads & QC
In week 1 quality control was done and k-mer count was performed. To find the optimal k, an additional script was used *best_k.sh* (from the [merqury github](https://github.com/marbl/merqury)), with a genome size of 150'000'000, which resulted in k=19. 

* Scripts: 01_01_fastqc_QC.sh, 01_02_jellyfish_kmer.sh
* Software: fastqc 0.11.9, jellyfish 2.3.0
* Input:
    * 1.1: Raw reads (fastq)
    * 1.2: Raw reads (fastq)
* Output: 01_read_QC
    * 1.1: fastqc
    * 1.2: kmer

### Week 2 - assembly
In week 2 three assemblies were made. Two whole genome assemblies created, using the Pacbio reads. The Illumina RNAseq reads were used for the transcriptome assembly.

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
In week 3 the draft assemblies were polished and evaluated. Only the two whole genome assemblies were polished using the Illumina reads. Then the assemblies were evaluated with three different methods.

A fist analysis was done with BUSCO. Gene sets that are expected to be "universal" and only be present in a single copy in groups of organisms, are used by BUSCO. If only a few such gene sets are found, this indicates an incomplete genome assembly. In contrast, if they occur in several copies, sequences are present that should be merged.

Furthermore, the whole genome assemblies were evaluated with QUAST. Here, the two whole genome assemblies with and without reference were examined. An *Arabidopsis thaliana* genome provided by the course leaders was used as a reference.

The assemblies were further evaluated with MERQURY. In this analysis, k-mers of an assembly are compared with k-mers of unassembled reads. With this, the quality and completeness of an assembly can be estimated.

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
In week 4 the assemblies were compared to each other and the *A. thaliana* reference. First the genomes are maped against the reference genome. Then the results were visualised in dotplots.

* Scripts: 04_01_nucmer_comparison.sh, 04_02_mummer_comparison.sh
* Software: mummer 4.0.0
* Input:
    * 4.1: Raw assembly of canu and flye, reference of *Arabidopsis thaliana* genome (fasta)
    * 4.2: Raw assembly of canu and flye, reference of *Arabidopsis thaliana* genome (fasta), nucmer delta file (delta)
* Output: 04_comparison
    * 4.1: nucmer
    * 4.2: mummer

### Week 5 - Annotation and classification of Transposable Elements (TEs)
Further analysis was done with the polished genome assembly with flye and the transcriptome assembly done with trinity from Faye Mohamed Mansour. 

In week 5 a filtered non-redundant TE library for the annoation of structurally intact and fragmented elements was produced. Then the TEs were classified according to their transposition mechanism. Only two retrotransposon superfamilies (Copia and Gypsy) were analysed. These class I TEs, transpose through an RNA intermediate with a "copy and paste" mechanism.

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
In week 6 the age of TEs (time of insertion) is estimated and the phylogenetic relations were analysed.
For the estimation of the age of TEs the assumption is made, that copies of the same family derive from one common active element and therefore they need to be identical at the time of insertion and then accumulate mutations over time. For this the script parseRM.pl was used. The input was taken from the EDTA pipeline.
Further phylogenetic relations between TEs were analysed. This allows to defined groups of closely related TEs that come from a common ancestral TE sequence. Most such studies analyse well characterised protein coding sequences, such as the reverse transcriptase, ribonuclease H and integrase for LTR retrotransposons, and transposase for DNA transposons. This analysis is done on the retrotransposon superfamilies copia (Ty3-RT) and gypsy (Ty1-RT). The sequences were aligned using clustal omega, then a phylogenetic tree was creaded with FastTree.

* Scripts: 06_01_TE_dating.sh, 06_02_TE_dating_plot_div.R, 06_03_TE_pyhlogeny.sh
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
In week 7 the genome was annotated and a database was created using the MAKER pipeline. It automatically compiles 1. *ab initio* prediction models, 2. evidence of expression and 3. sequence homology to known proteins, into gene annotations.

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
In week 8 the annotation quality was assessed. The completeness of the annotation was analysed using BUSCO. Further the sequence homology to functionally validated proteins was analysed. This was done using the UniProt database.

* Scripts: 08_01_BUSCO_evaluation.sh, 08_02_UniProt_evaluation.sh
* Software: busco 4.1.4, ncbi-blast 2.10.1+
* Input:
    * 8.1 & 8.2: polished.all.maker.proteins.fasta.renamed.fasta (output of maker then processed with script 07_02_gff_fasta_annotation.sh)
* Output: 08_Quality
    * 8.1: BUSCO
    * 8.2: UniProt

### Week 9 - Comparative genomics
In week 9 the sequence homology to protein of closely related speces was studied. A group of genes that descend from a single gene in the last common ancestor of different species is called an orthogroup. Visualising the percentages of genes in orthogroups helps with quality control. Normally, a high percentage of such genes is expected, but if a distant species is present in the proteomic data used, this is not the case.

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
