#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=QUAST_evaluation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_QUAST_evaluation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_QUAST_evaluation_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Quality_control/quast/4.6.0

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye
    # assembly_name=trinity

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        polish_evaluation_dir=${course_dir}/03_polish_evaluation
            evaulation_dir=${polish_evaluation_dir}/evaluation
                QUAST_dir=${evaulation_dir}/QUAST
                    assembly_QUAST_dir=${QUAST_dir}/${assembly_name}
    
    mkdir ${QUAST_dir}
    mkdir ${assembly_QUAST_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${polish_evaluation_dir}/polish/pilon/canu/***
    # assembly=${polish_evaluation_dir}/polish/pilon/flye/***
    # assembly=${course_dir}/02_assembly/trinity/Trinity.fasta

#Copy reference to Raw Data
    ln -s /data/courses/assembly-annotation-course/references ${raw_data_dir}

#Run QUAST to ...
    python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py --eukaryote --large --est-ref-size 125m --threads 8 --labels ${assembly_name} 
    ${assembly}
        #Options entered here are:
            #"--eukaryote": 
            #"--large": 
            #"--est-ref-size": 
            #"--threads": 
            #"--labels":
            #"-R (-r)":
            #"--features":
            #"(--pacbio)":
            #"(--no-sv)":

#Run QUAST to ...
    python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py --eukaryote --large --est-ref-size 125m --threads 8 --labels ${assembly_name} ${assembly}
        #Options entered here are:
            #"--eukaryote": 
            #"--large": 
            #"--est-ref-size": 
            #"--threads": 
            #"--labels":
    
    python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py --eukaryote --large --est-ref-size 125m --threads 8 --labels ${assembly_name} -R ${raw_data_dir} --features ${raw_data_dir}
    ${assembly}
        #Options entered here are:
            #"--eukaryote": 
            #"--large": 
            #"--est-ref-size": 
            #"--threads": 
            #"--labels":
            #"-R (-r)":
            #"--features":
