#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=06:00:00
#SBATCH --job-name=nucmer_comparison
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_nucmer_comparison_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_nucmer_comparison_%j.e
#SBATCH --partition=pall

### Run this script 3 times.
#1. assembly_name=canu;    assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta; reference=${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
#2. assembly_name=flye;    assembly=${course_dir}/02_assembly/flye/assembly.fasta;     reference=${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
#3. assembly_name=compare; assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta; reference=${course_dir}/02_assembly/flye/assembly.fasta

#Add the modules
    module add UHTS/Analysis/mummer/4.0.0beta1

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye
    # assembly_name=compare

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        comparison_dir=${course_dir}/04_comparison
            nucmer_dir=${comparison_dir}/nucmer
                assembly_nucmer_dir=${nucmer_dir}/${assembly_name}
    
    mkdir ${comparison_dir}
    mkdir ${nucmer_dir}
    mkdir ${assembly_nucmer_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta
    # assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Specify the reference genome
    reference=${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
    # reference=${course_dir}/02_assembly/flye/assembly.fasta

#Go to folder where results should be stored.
    cd ${assembly_nucmer_dir}

#Run nucmer to compare assemblies
    nucmer -b 1000 -c 1000 -p ${assembly_name} ${reference} ${assembly}
        #Options entered here are:
            #"-b 1000": Distance an alignment extension will attempt to extend poor scoring regions before giving up (default 200)
            #"-c 1000": Minimum cluster length
            #"-p": Set the output file prefix

