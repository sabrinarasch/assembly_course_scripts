#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=kmer
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_kmer_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_kmer_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Analysis/jellyfish/2.3.0

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    data_types=("Illumina" "pacbio" "RNAseq")
    raw_data_dir=${course_dir}/RawData

    kmer_dir=${course_dir}/02_kmer
        mkdir ${kmer_dir}

#Create the output directories
    for data_type in "${data_types[@]}"
    do
        kmer_data_dir=${kmer_dir}/${data_type}
            mkdir ${kmer_data_dir}
    done

#Do the k-mer counting
    for data_type in "${data_types[@]}"
    do
        jellyfish count -C -m 19 -s 5G -t 4 -o ${kmer_dir}/${data_type}/${data_type}.jf <(zcat ${raw_data_dir}/${data_type}/*.fastq.gz)
        #Options entered here are:
            #"count": count kmers
            #"-C": canonical kmers
            #"-m": kmer lenght
            #"-s": memory usage
            #"-t": number of used threads
            #"-o": ouput file
            #"<(zcat .../*.fastq.gz)": unziped input file
        jellyfish histo -t 4 ${kmer_dir}/${data_type}/${data_type}.jf > ${kmer_dir}/${data_type}/${data_type}.histo
        #Options entered here are:
            #"histo": create kmer count histogram
            #"-t": number of used threads
            #".../*.jf": input kmer count file
            #"> .../*.histo": output histogram file
    done
