## 06_03_TE_pyhlogeny
### <u>*family*_dataset_color_strip.txt</u>

Extract information from __*family*.cls.tsv__ from TEsorter. Different for Gypsia and Copia.

#TE_family hex_color_code Clade<br>
TE_00000298_INT#LTR/Copia #e40303 Ale

### <u>*family*_dataset_simplebar.txt</u><br>

Extract information from __polished.fasta.mod.EDTA.TEanno.sum__ from EDTA. Same for Gypsia and Copia.

#TE_family,family_size<br>
TE_00000298_INT#LTR/Copia,0

## 07_01_prot_annotation
genome=/data/users/srasch/assembly_course/RawData/polished.fasta #genome sequence (fasta file or fasta embeded in GFF3 file)

est=/data/users/srasch/assembly_course/RawData/assembly.fasta #set of ESTs or assembled mRNA-seq in fasta format

protein=/data/users/srasch/assembly_course/CDS_annotation/Atal_v10_CDS_proteins,/data/users/srasch/assembly_course/CDS_annotation/uniprot-plant_reviewed.fasta #protein sequence file in fasta format (i.e. from mutiple organisms)

model_org=

rmlib=/data/users/srasch/assembly_course/05_TE_annotation/TE_annotator/polished.fasta.mod.EDTA.TElib.fa #provide an organism specific repeat library in fasta format for RepeatMasker

repeat_protein=/data/users/srasch/assembly_course/CDS_annotation/PTREP20 #provide a fasta file of transposable element proteins for RepeatRunner

est2genome=1

protein2genome=1

TMP=$SCRATCH
