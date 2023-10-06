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

### Run this script 1 time.

#Add the modules
    module add UHTS/Assembler/trinityrnaseq/2.5.1

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        assembly_dir=${course_dir}/02_assembly
            trinity_dir=${assembly_dir}/trinity
    
    mkdir ${trinity_dir}

#Run Trinity to do the assembly
    Trinity --seqType fq --left ${raw_data_dir}/RNAseq/*_1.fastq.gz --right ${raw_data_dir}/RNAseq/*_2.fastq.gz --SS_lib_type FR --CPU 6 --max_memory 20G --output ${trinity_dir}
        #Options entered here are:
            #"--seqType": type of reads
            #"--left/--right": left reads/right reads
            #"--SS_lib_type FR": Strand-specific RNA-Seq read orientation
            #"--CPU": number of CPUs to use
            #"--max_memory": suggested max memory to use
            #"--output": name of directory for output
