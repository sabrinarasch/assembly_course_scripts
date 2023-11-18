#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=20:00:00
#SBATCH --job-name=bed_fasta_formatting
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_bed_fasta_formatting_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_bed_fasta_formatting_%j.e
#SBATCH --partition=pall

### Run this script 1 time.

#Add the modules
    module add UHTS/Analysis/SeqKit/0.13.2

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        input_dir=${course_dir}/07_prot_annotation/polished.maker.output.renamed
        genespace_dir=${course_dir}/09_genespace
            bed_dir=${genespace_dir}/bed
            peptide_dir=${genespace_dir}/peptide

    mkdir ${genespace_dir}
    mkdir ${bed_dir}
    mkdir ${peptide_dir}

#Specify the assembly to use
    genome="polished"
    data="C24"
    input_noseq=${input_dir}/${genome}.all.maker.noseq.gff.renamed.gff
    input_proteins=${input_dir}/${genome}.all.maker.proteins.fasta.renamed.fasta

#Get all contings and sort them by size
    awk '$3=="contig"' ${input_noseq} | sort -t $'\t' -k5 -n -r > ${genespace_dir}/${data}_size_sorted_contigs.txt

#Get the 10 longest
    head -n10 ${genespace_dir}/${data}_size_sorted_contigs.txt | cut -f1 > ${genespace_dir}/${data}_contigs.txt

#Create bed file
    awk '$3=="mRNA"' ${input_noseq} | cut -f 1,4,5,9 | sed 's/ID=//' | sed 's/;.\+//' | grep -w -f ${genespace_dir}/${data}_contigs.txt > ${bed_dir}/${data}.bed

#Get the gene IDs
    cut -f4 ${bed_dir}/${data}.bed > ${genespace_dir}/${data}_gene_IDs.txt

#Create fasta file
    cat ${input_proteins} | seqkit grep -r -f ${genespace_dir}/${data}_gene_IDs.txt | seqkit seq -i > ${peptide_dir}/${data}.fa
