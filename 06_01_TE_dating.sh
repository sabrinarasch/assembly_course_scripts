#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40000M
#SBATCH --time=01:00:00
#SBATCH --job-name=TE_dating
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_TE_dating_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_TE_dating_%j.e
#SBATCH --partition=pall

#Do step 1 - 3 this outside of script then let script run with 4 - 5:
    # 1. conda create -n assembly_course_environment
    # 2. conda activate assembly_course_environment
    # 3. conda install -c bioconda perl-bioperl
    
    # 4. conda activate assembly_course_environment
    # 5. sbatch 06_01_TE_dating.sh

genome=polished.fasta

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        dynamics_dir=${course_dir}/06_TE_dynamics
            TE_dating=${dynamics_dir}/TE_dating
    
    input_file=${course_dir}/05_TE_annotation/TE_annotator/${genome}.mod.EDTA.anno/${genome}.mod.out


    mkdir ${dynamics_dir}
    mkdir ${TE_dating}

cd ${TE_dating}

# perl parseRM.pl -i ${input_file} -l 50,1 -v #Output in input directory -> move it to output directory

sed '1d;3d' ${TE_dating}/${genome}.mod.out.landscape.Div.Rname.tab > ${genome}.sed.tab