#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=TE_dating
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_TE_dating_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_TE_dating_%j.e
#SBATCH --partition=pall

#Do step 1 - 3 this outside of script then let script run with 4 - 5:
    # 1. conda create -n assembly_course_environment
    # 2. conda activate assembly_course_environment
    # 3. conda install -c bioconda perl-bioperl
    # 4. conda activate assembly_course_environment
    # 5. sbatch 06_01_TE_dating.sh
    ### Run this script 3 times.
        #1. To create directories
        #2. To split the amount of DNA
        #3. To modify the output file

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        dynamics_dir=${course_dir}/06_TE_dynamics
            TE_dating=${dynamics_dir}/TE_dating

    mkdir ${dynamics_dir}
    mkdir ${TE_dating}

#Go to folder where results should be stored.
    cd ${TE_dating}

#Specify input directory and file
    input_dir=${course_dir}/05_TE_annotation/TE_annotator/polished.fasta.mod.EDTA.anno
    input_file=${input_dir}/polished.fasta.mod.out

#Download parseRM.pl and put it in TE_dating directory

#Split the amount of DNA by bins of % divergence (or My) for each repeat name, family or class.
    # perl parseRM.pl -i ${input_file} -l 50,1 -v
        #Options entered here are:
            #"-i":
            #"-l 50,1":
            #"-v":
    # mv ${in_dir}/*landscape* .

#Modify the output file by removing the 1st and the 3rd line.
    sed '1d;3d' ${TE_dating}/polished.fasta.mod.out.landscape.Div.Rname.tab > polished.fasta.sed.tab
