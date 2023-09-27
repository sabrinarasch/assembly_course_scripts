#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity_assembly
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_trinity_assembly_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_trinity_assembly_%j.e
#SBATCH --partition=pcourseassembly

#Add the modules
    module add UHTS/Assembler/trinityrnaseq/2.5.1

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    data_types=("Illumina" "pacbio" "RNAseq")    
    raw_data_dir=${course_dir}/RawData

    assembly_dir=${course_dir}/03_assembly
        mkdir ${assembly_dir}

#Create the output directories
    # for data_type in "${data_types[@]}"
    # do
    #     assembly_data_dir=${assembly_dir}/${data_type}
    #         mkdir ${assembly_data_dir}
    # done

#Do the asembly
