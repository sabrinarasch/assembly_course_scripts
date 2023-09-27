#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_flye_assembly_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_flye_assembly_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Assembler/flye/2.8.3

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    raw_data_dir=${course_dir}/RawData

    assembly_dir=${course_dir}/03_assembly
        mkdir ${assembly_dir}
    flye_dir=${assembly_dir}/flye
        mkdir ${flye_dir}

#Do the asembly
    flye --pacbio-raw ${raw_data_dir}/pacbio/*.fastq.gz -o ${flye_dir} -g 125m -t 8
