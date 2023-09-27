#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --job-name=canu_assembly
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_canu_assembly_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_canu_assembly_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Assembler/canu/2.1.1

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    raw_data_dir=${course_dir}/RawData

    assembly_dir=${course_dir}/03_assembly
        mkdir ${assembly_dir}
    canu_dir=${assembly_dir}/canu
        mkdir ${canu_dir}

#Do the asembly
    canu -p canu -d ${canu_dir} genomeSize=125m \
    maxThreads=16 maxMemory=64 \
    gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
    gridOptions="--partition=pall --mail-user=sabrina.rasch@students.unibe.ch" \
    -pacbio ${raw_data_dir}/pacbio/*.fastq.gz
