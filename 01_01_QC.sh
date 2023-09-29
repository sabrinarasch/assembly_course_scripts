#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=QC
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_QC_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_QC_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Quality_control/fastqc/0.11.9

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    data_types=("Illumina" "pacbio" "RNAseq")
    
    raw_data_dir=${course_dir}/RawData
        mkdir ${raw_data_dir}
    QC_dir=${course_dir}/01_read_QC
        mkdir ${QC_dir}
    fastqc_dir=${QC_dir}/fastqc

#Create the output and raw data directories and make a symbolic link to the data
    for data_type in "${data_types[@]}"
    do
        fastqc_data_dir=${fastqc_dir}/${data_type}
            mkdir ${fastqc_data_dir}

        data_dir=${raw_data_dir}/${data_type}
            mkdir ${data_dir}
        ln -s /data/courses/assembly-annotation-course/raw_data/C24/participant_2/${data_type}/* ${data_dir}
    done

#Do the quality analysis
    for data_type in "${data_types[@]}"
    do
        reads_dir=${raw_data_dir}/${data_type}
        fastqc -t 2 -o ${fastqc_dir}/${data_type} ${reads_dir}/*.fastq.gz
        #Options entered here are:
            #"-t": number of used threads
            #"-o": output directory
            #"*.fastq.gz": input fastq files
    done
