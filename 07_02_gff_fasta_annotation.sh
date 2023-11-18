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

### Run this script 1 time.

#Add the modules
    module add SequenceAnalysis/GenePrediction/maker/2.31.9

#Define other dictionaries and variables that are used
    genome="polished"

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        prot_annotation_dir=${course_dir}/07_prot_annotation
            renamed_dir=${prot_annotation_dir}/${genome}.maker.output.renamed
    
    mkdir ${renamed_dir}

#Specify input file
    index_log_input=${prot_annotation_dir}/polished.maker.output/${genome}_master_datastore_index.log

#Go to folder where results should be stored.
    cd ${renamed_dir}

#Generate gff and fasta files
    gff3_merge -d ${index_log_input} -o ${genome}.all.maker.gff
        #Options entered here are:
            #"-d": The location of the MAKER datastore index log file.
            #"-o": Alternate base name for the output files.

    gff3_merge -d ${index_log_input} -n -o ${genome}.all.maker.noseq.gff
        #Options entered here are:
            #"-d": The location of the MAKER datastore index log file.
            #"-n": Do not print fasta sequence in footer
            #"-o": Alternate base name for the output files.

    fasta_merge -d ${index_log_input} -o ${genome}
        #Options entered here are:
            #"-d": The location of the MAKER datastore index log file.
            #"-o": Alternate base name for the output files.

#Finalize the annotation
    protein=${genome}.all.maker.proteins.fasta
    transcript=${genome}.all.maker.transcripts.fasta
    gff=${genome}.all.maker.noseq.gff
    prefix=${genome}_

    cp ${gff} ${gff}.renamed.gff
    cp ${protein} ${protein}.renamed.fasta
    cp ${transcript} ${transcript}.renamed.fasta

    maker_map_ids --prefix ${prefix} --justify 7 ${gff}.renamed.gff > ${genome}.id.map
        #Options entered here are:
            #"--prefix": The prefix to use for all IDs (default = 'MAKER_')
            #"--justify": The unique integer portion of the ID will be right justified with '0's to this length (default = 8)

    map_gff_ids ${genome}.id.map ${gff}.renamed.gff
    map_fasta_ids ${genome}.id.map ${protein}.renamed.fasta
    map_fasta_ids ${genome}.id.map ${transcript}.renamed.fasta
