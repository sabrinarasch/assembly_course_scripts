#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=20:00:00
#SBATCH --job-name=gff_fasta_annotation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_gff_fasta_annotation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_gff_fasta_annotation_%j.e
#SBATCH --partition=pall

### Run this script X times.

#Add the modules
    module add SequenceAnalysis/GenePrediction/maker/2.31.9

#Define other dictionaries and variables that are used
    export TMPDIR=$SCRATCH
    genome="polished"

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        prot_annotation_dir=${course_dir}/07_TE_annotation
        # prot_annotation_dir=${course_dir}/07_prot_annotation
    
    # mkdir ${prot_annotation_dir}

#Go to folder where results should be stored.
    cd ${prot_annotation_dir}/${genome}.maker.output

#Generate gff and fasta files
    gff3_merge -d ${genome}_master_datastore_index.log -o ${genome}.all.maker.gff
    gff3_merge -d ${genome}_master_datastore_index.log -n -o ${genome}.all.maker.noseq.gff
    fasta_merge -d ${genome}_master_datastore_index.log -o ${genome}

#Finalize the annotation
    protein=${genome}.all.maker.proteins.fasta
    transcript=${genome}.all.maker.transcripts.fasta
    gff=${genome}.all.maker.noseq.gff
    prefix=${genome}_

    cp ${gff} ${gff}.renamed.gff
    cp ${protein} ${protein}.renamed.fasta
    cp ${transcript} ${transcript}.renamed.fasta

    maker_map_ids --prefix ${prefix} --justify 7 ${gff}.renamed.gff > ${genome}.id.map
    map_gff_ids ${genome}.id.map ${gff}.renamed.gff
    map_fasta_ids ${genome}.id.map ${protein}.renamed.fasta
    map_fasta_ids ${genome}.id.map ${transcript}.renamed.fasta
