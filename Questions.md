# Questions
These questions are copied from the [course website](https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/).

## Week 1
### Basic read statistics
* What are the read lengths of the different datasets?
    * *Illumina: 101; pacbio: 50-45262/50-44540; RNAseq: 101*
* What kind of coverage do you expect from the Pacbio and the Illumina WGS reads? (**hint**: lookup the expected genome size of *Arabidopsis thaliana*)
    * *(sequence lenght $\times$ total sequences) / genome size = coverage*
    * *genome size arabidopsis thaliana*
        * *135 Mb*
    * *Pacbio*
        * *ERR3415819: $\frac{(50 + 44540)}{2} \times 555119 / 135000000$ = 91.677*
        * *ERR3415820: $\frac{(50 + 45262)}{2} \times 367994 / 135000000$ = 61.756*
    * *Illumina*
        * *ERR3624577_1/ERR3624577_2: $ 101 \times 33787255 / 135000000$ = 25.278*
* Do all datasets have information on base quality?
    * *No the pacbio data set does not have information about the base quality.*

### Perform k-mer counting
* Is the estimated genome size and percentage of heterozygousity expected?
    * *Illumina: 124'986'561; 0.0591%*
    * *Pacbio: 14'389'033; 3.9%*
    * *RNAseq: 24'932'667; 3.86%*
* Bonus: Why are we using canonical k-mers? (use Google)
    * *When counting k-mers in sequencing reads, there is really no way to differentiate between k-mers and their reverse complement. What I mean by this is that seeing e.g. ACGGT is equivalent to seeing ACCGT, since the latter is the reverse complement of the former and the sequenced reads don't originate from a prescribed strand of the DNA. The -C command in jellyfish considers both a k-mer and its reverse complement as equivalent, and associates the count for both (the sum of the count of a kmer and its reverse complement) with the k-mer among the two that is lexicographically smaller. So, for example, above only ACCGT would be stored and its count would be equal to the number of occurrences of both ACCGT and ACGGT. If you don't include -C in your jellyfish options, these k-mers will be treated separately. There's nothing "wrong" with this, per-se, but it may not be what you want.* from [biostars](https://www.biostars.org/p/153170/)

## Week 3
### Assembly polishing
* How much does the polishing improve your assemblies (run the assembly evaluations on the polished and non-polished assemblies)?
    * *answer*

### Assembly evaluation
#### Assessing quality with BUSCO
* How do your genome assemblies look according to your BUSCO results? Is one genome assembly better than the other?
    * *canu:* C:98.4%[S:97.3%,D:1.1%],F:0.3%,M:1.3%,n:4596
    * *flye:* C:98.8%[S:97.7%,D:1.1%],F:0.1%,M:1.1%,n:4596
    * *They both look very similar and good*

| canu |                                     |
|------|-------------------------------------|
| 4524 | Complete BUSCOs (C)                 |
| 4474 | Complete and single-copy BUSCOs (S) |
|   50 | Complete and duplicated BUSCOs (D)  |
|   12 | Fragmented BUSCOs (F)               |
|   60 | Missing BUSCOs (M)                  |
| 4596 | Total BUSCO groups searched         |

| flye |                                     |
|------|-------------------------------------|
| 4543 | Complete BUSCOs (C)                 |
| 4492 | Complete and single-copy BUSCOs (S) |
|   51 | Complete and duplicated BUSCOs (D)  |
|    3 | Fragmented BUSCOs (F)               |
|   50 | Missing BUSCOs (M)                  |
| 4596 | Total BUSCO groups searched         |

* How does your transcriptome assembly look? Are there many duplicated genes? Can you explain the differences with the whole genome assemblies?
    * *trinity:* C:65.0%[S:20.1%,D:44.9%],F:7.6%,M:27.4%,n:4596
    * *There are actually more duplicated ones than single-copy; and there are a lot of missing ones.*
    * *For transcriptomes or annotated gene sets this indicates that these orthologs are indeed missing or the transcripts or gene models are so incomplete/fragmented that they could not even meet the criteria to be considered as fragmented.* from [BUSCO](https://busco.ezlab.org/busco_userguide.html#interpreting-the-results)

| trinity |                                     |
|------|-------------------------------------|
| 2985 | Complete BUSCOs (C)                 |
|  923 | Complete and single-copy BUSCOs (S) |
| 2062 | Complete and duplicated BUSCOs (D)  |
|  347 | Fragmented BUSCOs (F)               |
| 1264 | Missing BUSCOs (M)                  |
| 4596 | Total BUSCO groups searched         |

#### Assessing quality with QUAST
* How do your genome assemblies look according to your QUAST results? Is one genome assembly better than the other?
    * *answer*
* What additional information you get if you have a reference available?
    * *answer*

#### Assessing quality with merqury
* What are the consensus quality QV and error rate values of your assemblies?
    * *answer*
* What is the estimated completeness of your assemblies?
    * *answer*
* How does your copy-number spectra look like? Do they confirm the expected coverage?
    * *answer*
* Does one assembly perfom better than the other?
    * *answer*
