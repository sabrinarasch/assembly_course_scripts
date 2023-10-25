#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=TE_pyhlogeny
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_TE_pyhlogeny_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_TE_pyhlogeny_%j.e
#SBATCH --partition=pall

module add UHTS/Analysis/SeqKit/0.13.2
module add SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4
module add Phylogeny/FastTree/2.1.10

family_name=Gypsy
# family_name=Copia

family_tag=Ty3-RT
# family_tag=Ty1-RT

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        dynamics_dir=${course_dir}/06_TE_dynamics
            TE_phylogeny_dir=${dynamics_dir}/TE_phylogeny
                family_phylogeny_dir=${TE_phylogeny_dir}/${family_name}
    
    input_file=${course_dir}/05_TE_annotation/TE_sorter/${family_name}/${family_name}.dom.faa


    # mkdir ${TE_phylogeny_dir}
    # mkdir ${family_phylogeny_dir}

cd ${family_phylogeny_dir}

#Task 1
# grep ${family_tag} ${input_file} > ${family_name}_list.txt #make a list of RT proteins to extract

# sed -i 's/>//' ${family_name}_list.txt #remove ">" from the header

# sed -i 's/ .\+//' ${family_name}_list.txt #remove all characters following "empty space"

# seqkit grep -f ${family_name}_list.txt ${input_file} -o ${family_name}_RT.fasta

#Task 2
# sed -i 's/|.\+//' ${family_name}_RT.fasta #remove all characters following "|"

#Task 3
# clustalo -i ${family_name}_RT.fasta -o ${family_name}_protein_alignment.fasta

#Task 4
# FastTree -out ${family_name}_protein_alignment.tree ${family_name}_protein_alignment.fasta

#Task 5
#pars files by hand