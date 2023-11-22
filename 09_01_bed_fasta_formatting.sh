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
        comp_genomics_dir=${course_dir}/09_comp_genomics
            bed_dir=${comp_genomics_dir}/bed
            peptide_dir=${comp_genomics_dir}/peptide
            noseq_dir=${comp_genomics_dir}/noseq
            proteins_dir=${comp_genomics_dir}/proteins

    mkdir ${comp_genomics_dir}
    mkdir ${bed_dir}
    mkdir ${peptide_dir}
    mkdir ${noseq_dir}
    mkdir ${proteins_dir}

#Specify the assembly to use
    genome="polished"
    data="C24"
    input_noseq=${input_dir}/${genome}.all.maker.noseq.gff.renamed.gff
    input_proteins=${input_dir}/${genome}.all.maker.proteins.fasta.renamed.fasta

#Get all contings and sort them by size
    awk '$3=="contig"' ${input_noseq} | sort -t $'\t' -k5 -n -r > ${comp_genomics_dir}/${data}_size_sorted_contigs.txt

#Get the 10 longest
    head -n10 ${comp_genomics_dir}/${data}_size_sorted_contigs.txt | cut -f1 > ${comp_genomics_dir}/${data}_contigs.txt

#Create bed file
    awk '$3=="mRNA"' ${input_noseq} | cut -f 1,4,5,9 | sed 's/ID=//' | sed 's/;.\+//' | grep -w -f ${comp_genomics_dir}/${data}_contigs.txt > ${bed_dir}/${data}.bed

#Get the gene IDs
    cut -f4 ${bed_dir}/${data}.bed > ${comp_genomics_dir}/${data}_gene_IDs.txt

#Create fasta file
    cat ${input_proteins} | seqkit grep -r -f ${comp_genomics_dir}/${data}_gene_IDs.txt | seqkit seq -i > ${peptide_dir}/${data}.fa

#Copy files and change permissions (could run this directly in the terminal)
    # CDS_Genespace_dir=/data/courses/assembly-annotation-course/CDS_annotation/Genespace
    # CDS_busco_dir=/data/courses/assembly-annotation-course/CDS_annotation/busco
    # CDS_TE_dir=/data/courses/assembly-annotation-course/CDS_annotation/TE

    # cp ${input_noseq} ${CDS_Genespace_dir}/${data}.all.maker.noseq.gff.renamed.gff
    # cp ${input_proteins} ${CDS_Genespace_dir}/${data}.all.maker.proteins.fasta.renamed.fasta
    # cp ${bed_dir}/${data}.bed ${CDS_Genespace_dir}/${data}.bed
    # cp ${peptide_dir}/${data}.fa ${CDS_Genespace_dir}/${data}.fa
    # cp ${course_dir}/03_polish_evaluation/evaluation/BUSCO/flye/flye/short_summary.specific.brassicales_odb10.flye.txt ${CDS_busco_dir}/short_summary.specific.brassicales_odb10.${data}_genome.txt
    # cp ${course_dir}/08_Quality/BUSCO/BUSCO/short_summary.specific.brassicales_odb10.BUSCO.txt ${CDS_busco_dir}/short_summary.specific.brassicales_odb10.${data}_proteins.txt
    # cp ${course_dir}/05_TE_annotation/TE_annotator/polished.fasta.mod.EDTA.TEanno.gff3 ${CDS_TE_dir}/${data}.mod.EDTA.TEanno.gff3
    # cp ${course_dir}/05_TE_annotation/TE_annotator/polished.fasta.mod.EDTA.TEanno.sum ${CDS_TE_dir}/${data}.mod.EDTA.TEanno.sum

    # chmod +r ${CDS_Genespace_dir}/${data}.all.maker.noseq.gff.renamed.gff ${CDS_Genespace_dir}/${data}.all.maker.proteins.fasta.renamed.fasta ${CDS_Genespace_dir}/${data}.bed ${CDS_Genespace_dir}/${data}.fa ${CDS_busco_dir}/short_summary.specific.brassicales_odb10.${data}_genome.txt ${CDS_busco_dir}/short_summary.specific.brassicales_odb10.${data}_proteins.txt ${CDS_TE_dir}/${data}.mod.EDTA.TEanno.gff3 ${CDS_TE_dir}/${data}.mod.EDTA.TEanno.sum

    # cp ${CDS_Genespace_dir}/*.bed ${bed_dir}
    # cp ${CDS_Genespace_dir}/*.fa ${peptide_dir}
    # cp ${CDS_Genespace_dir}/*.gff ${noseq_dir}
    # cp ${CDS_Genespace_dir}/*.fasta ${proteins_dir}
    