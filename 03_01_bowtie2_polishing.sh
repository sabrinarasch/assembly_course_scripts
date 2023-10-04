#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=bowtie2_polishing
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_bowtie2_polishing_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_bowtie2_polishing_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Aligner/bowtie2/2.3.4.1
    module add UHTS/Analysis/samtools/1.10

#Create directories and variables
    course_dir=/data/users/srasch/assembly_course
    raw_data_dir=${course_dir}/RawData
    assembly_type=canu
    # assembly_type=flye

    polish_evaluation_dir=${course_dir}/03_polish_evaluation
        # mkdir ${polish_evaluation_dir}
    polish_dir=${polish_evaluation_dir}/polish
        # mkdir ${polish_dir}
        index_dir=${polish_dir}/index
            # mkdir ${index_dir}
            assembly_index_dir=${index_dir}/${assembly_type}
                # mkdir ${assembly_index_dir}
        align_dir=${polish_dir}/align
            # mkdir ${align_dir}
            assembly_align_dir=${align_dir}/${assembly_type}
                # mkdir ${assembly_align_dir}

#Assign input assembly
    assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta
    # assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Create index (bowtie2-build)
    # bowtie2-build ${assembly} index_bowtie2
        #Options entered here are:
            #"${assembly}":
            #"-index_bowtie2":
    # mv ${course_dir}/scripts/*.bt2 ${assembly_index_dir}/.

#Run bowtie2
    bowtie2 --sensitive-local -x ${assembly_index_dir}/* -1 ${raw_data_dir}/Illumina/*_1.fastq.gz -2 ${raw_data_dir}/Illumina/*_2.fastq.gz -S ${assembly_align_dir}/${assembly_name}.sam
        #Options entered here are:
            #"--sensitive-local":
            #"-x":
            #"-1/-2":
            #"-S":

#Convert SAM to BAM
    #Index reference for samtools (after once doing this it can be commented)
    #     samtools faidx ${assembly} -o ${assembly_align_dir}/sam_index.fa.fai
        #Options entered here are:
            #"faidx": Index reference sequence in the FASTA format.
            #"-o": Write FASTA to file rather than to stdout.

    #Convert SAM to BAM
        # samtools view -b -t ${assembly_align_dir}/sam_index.fa.fai ${assembly_align_dir}/${assembly_name}.sam > ${assembly_align_dir}/${assembly_name}_unsorted.bam
        #Options entered here are:
            #"view": Views and converts SAM/BAM/CRAM files.
            #"-b": Output in the BAM format.
            #"-t: A tab-delimited file. Each line must contain the reference name in the first column and the length of the reference in the second column, with one line for each distinct reference.
            #"*.sam": Input file.
            #"*_unsorted.bam": Output file.

    #Sort BAM
        # samtools sort -o ${assembly_align_dir}/${assembly_name}.bam ${assembly_align_dir}/${assembly_name}_unsorted.bam
        #Options entered here are:
            #"sort": Sort alignments by leftmost coordinates, or by read name when -n is used. 
            #"-o": Write the final sorted output to file, rather than to standard output.
            #"*_unsorted.bam": Input file

    #Index BAM
        # samtools index ${assembly_align_dir}/${assembly_name}.bam
        #Options entered here are:
            #"index": Index coordinate-sorted BGZIP-compressed SAM, BAM or CRAM files for fast random access.
