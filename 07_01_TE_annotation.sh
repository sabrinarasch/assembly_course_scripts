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


module add SequenceAnalysis/GenePrediction/maker/2.31.9


#Task 1
#Specify directory structure and create them
    course_dir=/data/users/srasch/assembly_course
        TE_annotation_dir=${course_dir}/07_TE_annotation
            # TE_dating=${dynamics_dir}/TE_dating
    
    mkdir ${TE_annotation_dir}

cd ${TE_annotation_dir}

#Task 2
# maker -CTL

#Task 3 adapt file
# cp /data/users/mfaye/assembly_course/data/assemblies/trinity_out/assembly.fasta /data/users/srasch/assembly_course

#Task 4

COURSEDIR=/data/courses/assembly-annotation-course
my_dir=/data/users/srasch/assembly_course
software_dir=/software

export SLURM_EXPORT_ENV=ALL
export LIBDIR=/software/SequenceAnalysis/Repeat/RepeatMasker/4.0.7/Libraries/
export REPEATMASKER_DIR=/software/SequenceAnalysis/Repeat/RepeatMasker/4.0.7/RepeatMasker

mpiexec -n 16 singularity exec \
--bind $SCRATCH:/TMP \
--bind ${COURSEDIR}:/${COURSEDIR} \
--bind ${my_dir}:/${my_dir} \
--bind ${software_dir}:/${software_dir} \
${COURSEDIR}/containers2/MAKER_3.01.03.sif \
maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_exe.ctl
