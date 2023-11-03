#!/usr/bin/env bash

#SBATCH --mem-per-cpu=12G
#SBATCH --time=20:00:00
#SBATCH --job-name=TE_annotation
#SBATCH --mail-user=sabrina.rasch@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/srasch/assembly_course/Output/output_TE_annotation_%j.o
#SBATCH --error=/data/users/srasch/assembly_course/Error/error_TE_annotation_%j.e
#SBATCH --partition=pall
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16

### Run this script 2 times.
#1. To make the control files
#2. To run maker

#Add the modules
    module add SequenceAnalysis/GenePrediction/maker/2.31.9

#Define other dictionaries and variables that are used
    COURSE_DIR=/data/courses/assembly-annotation-course
    software_dir=/software


#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        TE_annotation_dir=${course_dir}/07_TE_annotation
    
    mkdir ${TE_annotation_dir}

#Go to folder where results should be stored.
    cd ${TE_annotation_dir}

#Copy data files from Monsur to RawData and make soft link course folder
    cp /data/users/mfaye/assembly_course/data/assemblies/trinity_out/assembly.fasta ${course_dir}/RawData

#Create control files
# singularity exec \
# --bind $SCRATCH \
# --bind ${COURSE_DIR} \
# --bind ${course_dir} \
# --bind ${software_dir} \
# ${COURSE_DIR}/containers2/MAKER_3.01.03.sif \
# maker -CTL
    #Options entered here are:
        #"singularity exec": execute container with given options
        #"--bind": a user-bind path specification.
        #"${COURSE_DIR}/containers2/MAKER_3.01.03.sif": Singularity Image Format container to be executed
        #"maker": command to be executed
        #"-CTL": Generate empty control files in the current directory.

#Run MAKER with MPI
mpiexec -n 16 singularity exec \
--bind $SCRATCH \
--bind ${COURSE_DIR} \
--bind ${course_dir} \
--bind ${software_dir} \
${COURSE_DIR}/containers2/MAKER_3.01.03.sif \
maker -mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl
    #Options entered here are:
        #"mpiexec -n 16 singularity exec": execute container with given options
        #"--bind": a user-bind path specification.
        #"${COURSE_DIR}/containers2/MAKER_3.01.03.sif": Singularity Image Format container to be executed
        #"maker -mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl": command to be executed
