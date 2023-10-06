#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=48G
#SBATCH --time=06:00:00
#SBATCH --job-name=QUAST_evaluation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_QUAST_evaluation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_QUAST_evaluation_%j.e
#SBATCH --partition=pall

#Add the modules
    module add UHTS/Quality_control/quast/4.6.0

#Specify name of assembly (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly_name=canu
    # assembly_name=flye

#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        raw_data_dir=${course_dir}/RawData
        polish_evaluation_dir=${course_dir}/03_polish_evaluation
            evaulation_dir=${polish_evaluation_dir}/evaluation
                QUAST_dir=${evaulation_dir}/QUAST
                    assembly_QUAST_dir=${QUAST_dir}/${assembly_name}
                        no_ref_dir=${assembly_QUAST_dir}/no_reference
                        ref_dir=${assembly_QUAST_dir}/reference
    
    mkdir ${QUAST_dir}
    mkdir ${assembly_QUAST_dir}
    mkdir ${no_ref_dir}
    mkdir ${ref_dir}

#Specify the assembly to use (!!!COMMENT OUT THE ONE YOU ARE NOT USING!!!)
    assembly=${polish_evaluation_dir}/polish/pilon/canu/canu.fasta
    # assembly=${polish_evaluation_dir}/polish/pilon/flye/flye.fasta

#Copy reference to Raw Data
    ln -s /data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa ${raw_data_dir}

#Run QUAST to assess quality of the assemblies
    #Without reference
        python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o ${no_ref_dir} -m 3000 -t 8 -l ${assembly_name} -e --est-ref-size 125000000 -i 500 -x 7000 ${assembly}
            #Options entered here are:
                #"-o": Directory to store all result files
                #"-m": Lower threshold for contig length.
                #"-t": Maximum number of threads
                #"-l": Human-readable assembly names. Those names will be used in reports, plots and logs.
                #"-e": Genome is eukaryotic. Affects gene finding, conserved orthologs finding and contig alignment.
                #"--est-ref-size": Estimated reference size
                #"-i": the minimum alignment length
                #"-x": Lower threshold for extensive misassembly size. All relocations with inconsistency less than extensive-mis-size are counted as local misassemblies
    
    #With reference
        python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o ${ref_dir} -R ${raw_data_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -m 3000 -t 8 -l ${assembly_name} -e --est-ref-size 125000000 -i 500 -x 7000 ${assembly}
            #Options entered here are:
                #"-o": Directory to store all result files
                #"-R": Reference genome file
                #"-m": Lower threshold for contig length.
                #"-t": Maximum number of threads
                #"-l": Human-readable assembly names. Those names will be used in reports, plots and logs.
                #"-e": Genome is eukaryotic. Affects gene finding, conserved orthologs finding and contig alignment.
                #"--est-ref-size": Estimated reference size
                #"-i": the minimum alignment length
                #"-x": Lower threshold for extensive misassembly size. All relocations with inconsistency less than extensive-mis-size are counted as local misassemblies
