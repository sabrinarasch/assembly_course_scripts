#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=TE_sorter
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_TE_sorter_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_TE_sorter_%j.e
#SBATCH --partition=pall

### Run this script 4 times.
#1. family_name=Gypsy;                                         family_sorter_dir=${TE_sorter_dir}/${family_name}; cat ${TE_annotator_dir}/polished.fasta.mod.EDTA.TElib.fa | seqkit grep -r -p "Gypsy" > ${family_sorter_dir}/Gypsy.fa;  family_file=${family_sorter_dir}/Gypsy.fa
#2. family_name=Copia;                                         family_sorter_dir=${TE_sorter_dir}/${family_name}; cat ${TE_annotator_dir}/polished.fasta.mod.EDTA.TElib.fa | seqkit grep -r -p "Copia" > ${family_sorter_dir}/Copia.fa;  family_file=${family_sorter_dir}/Copia.fa
#3. family_name=Gypsy; brass_dir=${TE_sorter_dir}/brassicacea; family_sorter_dir=${brass_dir}/${family_name};     cat ${brass_dir}/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p "Gypsy" > ${family_sorter_dir}/Gypsy.fa; family_file=${family_sorter_dir}/Gypsy.fa
#4. family_name=Copia; brass_dir=${TE_sorter_dir}/brassicacea; family_sorter_dir=${brass_dir}/${family_name};     cat ${brass_dir}/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p "Copia" > ${family_sorter_dir}/Copia.fa; family_file=${family_sorter_dir}/Copia.fa

module add UHTS/Analysis/SeqKit/0.13.2

#Define other dictionaries and variables that are used
    COURSE_DIR=/data/courses/assembly-annotation-course

    family_name=Gypsy
    # family_name=Copia

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        annotation_dir=${course_dir}/05_TE_annotation
            TE_annotator_dir=${annotation_dir}/TE_annotator
            TE_sorter_dir=${annotation_dir}/TE_sorter
                family_sorter_dir=${TE_sorter_dir}/${family_name}
                # brass_dir=${TE_sorter_dir}/brassicacea
                    # family_sorter_dir=${brass_dir}/${family_name}
    
    mkdir ${TE_sorter_dir}
    # mkdir ${brass_dir}
    mkdir ${family_sorter_dir}

#Create the input file for the TEsorter
    cat ${TE_annotator_dir}/polished.fasta.mod.EDTA.TElib.fa | seqkit grep -r -p "Gypsy" > ${family_sorter_dir}/Gypsy.fa
    # cat ${TE_annotator_dir}/polished.fasta.mod.EDTA.TElib.fa | seqkit grep -r -p "Copia" > ${family_sorter_dir}/Copia.fa
    # cat ${course_dir}/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p "Gypsy" > ${family_sorter_dir}/Gypsy.fa
    # cat ${course_dir}/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta | seqkit grep -r -p "Copia" > ${family_sorter_dir}/Copia.fa
        #Options entered here are:
            #"grep":
            #"-r":
            #"-p":

#Define family file
    family_file=${family_sorter_dir}/Gypsy.fa
    # family_file=${family_sorter_dir}/Copia.fa

#Go to folder where results should be stored.
    cd ${family_sorter_dir}

#Run  to TE sorter to classify TE to mechanism; do not indent
singularity exec \
--bind ${COURSE_DIR} \
--bind ${family_sorter_dir} \
${COURSE_DIR}/containers2/TEsorter_1.3.0.sif \
TEsorter ${family_file} -db rexdb-plant -pre ${family_name}
    #Options entered here are:
        #"singularity exec":
        #"--bind ${COURSE_DIR}:":
        #"--bind ${family_sorter_dir}":
        #"${COURSE_DIR}/containers2/TEsorter_1.3.0.sif":
        #"-db rexdb-plant":
        #"-pre":
