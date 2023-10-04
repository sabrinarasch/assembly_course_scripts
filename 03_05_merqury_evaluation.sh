#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=merqury_evaluation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_merqury_evaluation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_merqury_evaluation_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Quality_control/quast/4.6.0

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        polish_evaluation_dir=${course_dir}/03_polish_evaluation
            evaulation_dir=${polish_evaluation_dir}/evaluation
                merqury_dir=${evaulation_dir}/merqury
                    assembly_merqury_dir=${merqury_dir}/${assembly_name}
    
    mkdir ${merqury_dir}
    mkdir ${assembly_merqury_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${polish_evaluation_dir}/polish/pilon/canu/***
    # assembly=${polish_evaluation_dir}/polish/pilon/flye/***


