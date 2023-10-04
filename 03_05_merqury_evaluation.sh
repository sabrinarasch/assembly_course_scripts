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



#meryl mit raw ilumina reads db vorbereiten
#meryl in ?canu/2.1.1/bin/meryl?
#In container bind also ordner of raw data (soft link)







WORKDIR=/path/to/work/directory

apptainer exec \
--bind $WORKDIR,$RAWDATADIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl k=19 count output read_1.meryl read_1.fastq.gz; \
meryl k=19 count output read_2.meryl read_2.fastq.gz; \
meryl union-sum output genome.meryl read*.meryl

#read_1.meryl in $SCRATCH
#read_1.fast.gz -> raw ilumina read
#genome.meryl in folder -> full path


apptainer exec \
--bind $WORKDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
genome.meryl \ #FULLPATH TO MERYL CREATED ABOVE
assemblies.fasta \ #FULLPATH TO ASSEMBLY THAT SHOULD BE EVALUATED
flye_test #FULLPATH TO OUTPUT PREFIX

#MAKE TWO SCRIPTS ONE WITH MERYL AND ONE WITH MERCURY