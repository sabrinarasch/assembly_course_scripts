#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=BUSCO_evaluation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_BUSCO_evaluation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_BUSCO_evaluation_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Analysis/busco/4.1.4

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye
    # assembly_name=trinity

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        polish_evaluation_dir=${course_dir}/03_polish_evaluation
            evaulation_dir=${polish_evaluation_dir}/evaluation
                BUSCO_dir=${evaulation_dir}/BUSCO
                    assembly_BUSCO_dir=${BUSCO_dir}/${assembly_name}
    
    mkdir ${evaulation_dir}
    mkdir ${BUSCO_dir}
    mkdir ${assembly_BUSCO_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
    # assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta
    # assembly=${course_dir}/02_assembly/trinity/Trinity.fasta

#Go to folder where the evaluation results will be stored
    cd ${assembly_BUSCO_dir}

#Make a copy of the augustus config directory to a location where I have write permission
    cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
    export AUGUSTUS_CONFIG_PATH=./augustus_config

#Run busco to assess the quality of the assemblies
    busco -i ${assembly} -l brassicales_odb10 -o ${assembly_name} -m genome --cpu 8
        #Options entered here are:
            #"-i": Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set.
            #"-l": Specify the name of the BUSCO lineage to be used.
            #"-o": defines the folder that will contain all results, logs, and intermediate data
            #"-m": Specify which BUSCO analysis mode to run, genome, proteins, transcriptome (!!!FOR THE CANU AND FLYE ASSEMBLY I USE GENOME AND FOR THE TRINITRY ASSEMBLY I USE TRANSCRIPTOME!!!)
            #"--cpu": Specify the number (N=integer) of threads/cores to use.

#Remove the augustus config directory again
    rm -r ./augustus_config