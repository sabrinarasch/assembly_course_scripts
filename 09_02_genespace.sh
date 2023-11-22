#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=20:00:00
#SBATCH --job-name=genespace
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_genespace_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_genespace_%j.e
#SBATCH --partition=pall

### Run this script 1 time.
    # copy /data/users/grochat/genome_assembly_course/scripts/genespace_1.1.4.sif
    # copy /data/users/srasch/assembly_course/CDS_annotation/scripts/Parse_Orthofinder.R
    # copy /data/users/rschwob/01_assembly_annotation_course/scripts/genespace.R
    # Download MCScanX-master from github, unzip, cd into directory and execute $make

#Add the modules
    module add UHTS/Analysis/SeqKit/0.13.2

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        comp_genomics_dir=${course_dir}/09_comp_genomics
            genespace_dir=${comp_genomics_dir}/genespace
    
    mkdir ${genespace_dir}

    genespace_image=${course_dir}/scripts/genespace_1.1.4.sif
    genespace_script=${course_dir}/scripts/genespace.R

apptainer exec \
--bind ${course_dir} \
${genespace_image} Rscript ${genespace_script}

mv ${comp_genomics_dir}/dotplots ${genespace_dir}
mv ${comp_genomics_dir}/orthofinder ${genespace_dir}
mv ${comp_genomics_dir}/pangenes ${genespace_dir}
mv ${comp_genomics_dir}/results ${genespace_dir}
mv ${comp_genomics_dir}/riparian ${genespace_dir}
mv ${comp_genomics_dir}/syntenicHits ${genespace_dir}
mv ${comp_genomics_dir}/tmp ${genespace_dir}
