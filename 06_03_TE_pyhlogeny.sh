#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=TE_pyhlogeny
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_TE_pyhlogeny_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_TE_pyhlogeny_%j.e
#SBATCH --partition=pall

### Run this script 2 times.
#1. family_name=Gypsy; family_tag=Ty3-RT
#2. family_name=Copia; family_tag=Ty1-RT

#Add the modules
    module add UHTS/Analysis/SeqKit/0.13.2
    module add SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4
    module add Phylogeny/FastTree/2.1.10

#Define other dictionaries and variables that are used
    family_name=Gypsy
    # family_name=Copia

    family_tag=Ty3-RT
    # family_tag=Ty1-RT

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        dynamics_dir=${course_dir}/06_TE_dynamics
            TE_phylogeny_dir=${dynamics_dir}/TE_phylogeny
                family_phylogeny_dir=${TE_phylogeny_dir}/${family_name}

    mkdir ${TE_phylogeny_dir}
    mkdir ${family_phylogeny_dir}

#Go to folder where results should be stored.
    cd ${family_phylogeny_dir}

#Specify input file
    input_file=${course_dir}/05_TE_annotation/TE_sorter/${family_name}/${family_name}.dom.faa

#Extract RT protein sequences from the *.dom.faa
    grep ${family_tag} ${input_file} > ${family_name}_list.txt #make a list of RT proteins to extract
    sed -i 's/>//' ${family_name}_list.txt #remove ">" from the header
    sed -i 's/ .\+//' ${family_name}_list.txt #remove all characters following "empty space"
    seqkit grep -f ${family_name}_list.txt ${input_file} -o ${family_name}_RT.fasta
        #Options entered here are:
            #"grep": search sequences by ID/name/sequence/sequence motifs, mismatch allowed
            #"-f": pattern file
            #"-o": out file

#Shorten the identifiers of RT sequences.
    sed -i 's/|.\+//' ${family_name}_RT.fasta #remove all characters following "|"

#Align the sequences
    clustalo -i ${family_name}_RT.fasta -o ${family_name}_protein_alignment.fasta
        #Options entered here are:
            #"-i": Multiple sequence input file
            #"-o": Multiple sequence alignment output file

#Create a phylogenetic tree with FastTree
    FastTree -out ${family_name}_protein_alignment.tree ${family_name}_protein_alignment.fasta
