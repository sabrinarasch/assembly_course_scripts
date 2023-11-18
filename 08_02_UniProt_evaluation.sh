#!/usr/bin/env bash

#SBATCH --cpus-per-task=30
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --job-name=UniProt_evaluation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_UniProt_evaluation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_UniProt_evaluation_%j.e
#SBATCH --partition=pall

### Run this script 1 times.

#Add the modules
    module add Blast/ncbi-blast/2.10.1+

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        quality_dir=${course_dir}/08_Quality
            UniProt_dir=${quality_dir}/UniProt
                blastdb_dir=${UniProt_dir}/blastdb
   
    mkdir ${UniProt_dir}
    mkdir ${blastdb_dir}

#Specify the assembly to use
    input_dir=${course_dir}/07_prot_annotation/polished.maker.output.renamed/
    assembly=${input_dir}/polished.all.maker.proteins.fasta.renamed.fasta

#Go to folder where the evaluation results will be stored
    cd ${UniProt_dir}

#Align protein against UniProt database
    makeblastdb -in ${course_dir}/CDS_annotation/MAKER/uniprot_viridiplantae_reviewed.fa -dbtype prot -out ${blastdb_dir}/uniprot.db

    blastp -query ${assembly} -db ${blastdb_dir}/uniprot.db -num_threads 30 -outfmt 6 -evalue 1e-10 -out ${UniProt_dir}/blastp.out
