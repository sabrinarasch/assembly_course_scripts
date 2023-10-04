#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=pilon_polishing
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_pilon_polishing_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_pilon_polishing_%j.e
#SBATCH --partition=pall

#Add the modules
    java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        polish_evaluation_dir=${course_dir}/03_polish_evaluation
            polish_dir=${polish_evaluation_dir}/polish
                pilon_dir=${polish_dir}/pilon
                    assembly_pilon_dir=${pilon_dir}/${assembly_name}
    
    mkdir ${pilon_dir}        
    mkdir ${assembly_pilon_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${course_dir}/02_assembly/canu/canu.contigs.fasta
    # assembly=${course_dir}/02_assembly/flye/assembly.fasta

#Run pilon to polish the assemblies
    pilon --genome ${assembly} --frags ${polish_dir}/align/${assembly_name}/${assembly_name}.bam --output ${assembly_name} --outdir ${assembly_pilon_dir}
        #Options entered here are:
            #"--gemone":
            #"--frags":
            #"--output":
            #"--outdir":