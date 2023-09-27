#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_flye_assembly_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_flye_assembly_%j.e
#SBATCH --partition=pcourseassembly

#Add the modules
    module add Flye/2.9-GCC-10.3.0

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
