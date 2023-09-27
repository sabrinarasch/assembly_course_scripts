#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_trinity_assembly_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_trinity_assembly_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Assembler/trinityrnaseq/2.5.1

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    raw_data_dir=${course_dir}/RawData

    assembly_dir=${course_dir}/03_assembly
        mkdir ${assembly_dir}
    trinity_dir=${assembly_dir}/trinity
        mkdir ${trinity_dir}

#Do the asembly
    Trinity --seqType fq --left ${raw_data_dir}/RNAseq/*_1.fastq.gz --right ${raw_data_dir}/RNAseq/*_2.fastq.gz --SS_lib_type RF --CPU 6 --max_memory 20G --output ${trinity_dir}