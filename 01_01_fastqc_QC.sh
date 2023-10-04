#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc_QC
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_fastqc_QC_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_fastqc_QC_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Quality_control/fastqc/0.11.9

#Specify types of data
    data_types=("Illumina" "pacbio" "RNAseq")

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        QC_dir=${course_dir}/01_read_QC
            fastqc_dir=${QC_dir}/fastqc

    mkdir ${raw_data_dir}
    mkdir ${QC_dir}
    for data_type in "${data_types[@]}"
    do
        fastqc_data_dir=${fastqc_dir}/${data_type}
            mkdir ${fastqc_data_dir}

        data_dir=${raw_data_dir}/${data_type}
            mkdir ${data_dir}
        
        #Make a soft link to the data
        ln -s /data/courses/assembly-annotation-course/raw_data/C24/participant_2/${data_type}/* ${data_dir}
    done

#Run fastqc to do the quality analysis
    for data_type in "${data_types[@]}"
    do
        reads_dir=${raw_data_dir}/${data_type}
        fastqc -t 2 -o ${fastqc_dir}/${data_type} ${reads_dir}/*.fastq.gz
            #Options entered here are:
                #"-t": number of used threads
                #"-o": output directory
                #"*.fastq.gz": input fastq files
    done
