#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=meryl_evaluation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_meryl_evaluation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_meryl_evaluation_%j.e
#SBATCH --partition=pall

### Run this script 1 time.

#Add the modules
    module add UHTS/Assembler/canu/2.1.1

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        polish_evaluation_dir=${course_dir}/03_polish_evaluation
            evaulation_dir=${polish_evaluation_dir}/evaluation
                meryl_dir=${evaulation_dir}/meryl
    
    mkdir ${meryl_dir}

#Specify where the raw reads are stored (no soft link)
    data_dir=/data/courses/assembly-annotation-course/raw_data/C24/participant_2/Illumina

#Run meryl to create db for merqury
    meryl k=19 count output $SCRATCH/read_1.meryl ${data_dir}/*1.fastq.gz
    meryl k=19 count output $SCRATCH/read_2.meryl ${data_dir}/*2.fastq.gz
        #Options entered here are:
            #"k": Create mers of size K bases
            #"count": Count the occurrences of canonical kmers in the input.
            #"output": write kmers generated by the present command to an output

    meryl union-sum output ${meryl_dir}/genome.meryl $SCRATCH/read*.meryl
        #Options entered here are:
            #"union-sum": return kmers that occur in any input, set the count to the sum of the counts
            #"output": write kmers generated by the present command to an output
