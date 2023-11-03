#!/usr/bin/env bash

#SBATCH --cpus-per-task=50
#SBATCH --mem=10G
#SBATCH --time=03:00:00
#SBATCH --job-name=EDTA_annotation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_EDTA_annotation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_EDTA_annotation_%j.e
#SBATCH --partition=pall

### Run this script 1 time.

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        annotation_dir=${course_dir}/05_TE_annotation
            TE_annotator_dir=${annotation_dir}/TE_annotator
    
    mkdir ${annotation_dir}
    mkdir ${TE_annotator_dir}

#Copy data files from Monsur to RawData and make soft link course folder
    cp /data/users/mfaye/assembly_course/data/assemblies/flye_out/polished.fasta ${raw_data_dir}
    ln -s /data/courses/assembly-annotation-course/CDS_annotation ${course_dir}

#Go to folder where results should be stored.
    cd ${TE_annotator_dir}

#Run EDTA for automated annotation; do not indent
singularity exec \
--bind ${course_dir} \
--bind ${TE_annotator_dir} \
--bind ${raw_data_dir} \
${course_dir}/containers2/EDTA_v1.9.6.sif \
EDTA.pl \
--genome ${raw_data_dir}/polished.fasta \
--species others \
--step all \
--cds ${course_dir}/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated \
--anno 1 \
--threads 50
    #Options entered here are:
        #"singularity exec": execute container with given options
        #"--bind": a user-bind path specification.
        #"${course_dir}/containers2/EDTA_v1.9.6.sif": Singularity Image Format container to be executed
        #"EDTA.pl": command to be executed
        #"--genome": The genome FASTA file.
        #"--species others": Specify the species for identification of TIR candidates.
        #"--step all": Specify which steps you want to run EDTA. all: run the entire pipeline
        #"--cds": Provide a FASTA file containing the coding sequence (no introns, UTRs, nor TEs) of this genome or its close relative.
        #"--anno 1": Perform (1) or not perform (0, default) whole-genome TE annotation after TE library construction.
        #"--threads 50": Number of theads to run this script
