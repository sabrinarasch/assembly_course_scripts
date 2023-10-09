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
    * *busco raw*
        * *canu:* C:94.9% [S:93.3%, D:1.6%], F:1.3%, M:3.8%, n:4596
        * *flye:* C:98.1% [S:96.9%, D:1.2%], F:0.4%, M:1.5%, n:4596
        * *With the evaluation with busco it does improve a little bit. The assembly with canu (C: raw: 94.9%, poli: 98.4%; M: raw: 3.8%, poli: 1.3%) improves more than the assembly with flye (C: raw: 98.1%, poli: 98.8%; M: raw: 1.5%, poli: 1.1%)*

### Assembly evaluation
#### Assessing quality with BUSCO (Complete score above 95% is good)

|                               busco | canu | flye | trinity | canu | flye |
|                                     | poli | poli |     raw |  raw |  raw |
|-------------------------------------|------|------|---------|------|------|
|                 Complete BUSCOs (C) | 4524 | 4543 |    2985 | 4361 | 4509 |
| Complete and single-copy BUSCOs (S) | 4474 | 4492 |     923 | 4288 | 4455 |
|  Complete and duplicated BUSCOs (D) |   50 |   51 |    2062 |   73 |   54 |
|               Fragmented BUSCOs (F) |   12 |    3 |     347 |   61 |   17 |
|                  Missing BUSCOs (M) |   60 |   50 |    1264 |  174 |   70 |
|         Total BUSCO groups searched | 4596 | 4596 |    4596 | 4596 | 4596 |

* How do your genome assemblies look according to your BUSCO results? Is one genome assembly better than the other?
    * *canu:* C: 98.4% [S:97.3%, D:1.1%], F:0.3%, M:1.3%, n:4596
    * *flye:* C: 98.8% [S:97.7%, D:1.1%], F:0.1%, M:1.1%, n:4596
    * *They both look very similar and good*

* How does your transcriptome assembly look? Are there many duplicated genes? Can you explain the differences with the whole genome assemblies?
    * *trinity:* C:65.0% [S:20.1%, D:44.9%], F:7.6%, M:27.4%, n:4596
    * *There are actually more duplicated ones than single-copy; and there are a lot of missing ones.*
    * *For transcriptomes or annotated gene sets this indicates that these orthologs are indeed missing or the transcripts or gene models are so incomplete/fragmented that they could not even meet the criteria to be considered as fragmented.* from [BUSCO](https://busco.ezlab.org/busco_userguide.html#interpreting-the-results)

#### Assessing quality with QUAST

|Assembly | canu poli | flye poli |  canu raw |  flye raw |
|         |    no_ref |    no_ref |    no_ref |    no_ref |
|---------|-----------|-----------|-----------|-----------|
|    NG50 |    433815 |   8822047 |    433505 |   8819554 |
|    NG75 |    211025 |   1705972 |    209127 |   1705414 |
|    LG50 |        79 |         6 |        79 |         6 |
|    LG75 |       183 |        13 |       184 |        13 |

|                    Assembly |     canu poli |     flye poli |      canu raw |      flye raw |
|                             |           ref |           ref |           ref |           ref |
|-----------------------------|---------------|---------------|---------------|---------------|
|                        NG50 |        472804 |       8822047 |        472513 |       8819554 |
|                        NG75 |        238409 |       3987995 |        237999 |       3987766 |
|                        LG50 |            73 |             6 |            73 |             6 |
|                        LG75 |           165 |            11 |           166 |            11 |
|             # misassemblies |           799 |           815 |           796 |           816 |
|      # misassembled contigs |           282 |            91 |           279 |            93 |
| Misassembled contigs length |      79867417 |     113588575 |      79831032 |     113612529 |
|       # local misassemblies |          4865 |          4830 |          4821 |          4814 |
|    # unaligned mis. contigs |            46 |            35 |            46 |            36 |
|         # unaligned contigs | 14 + 441 part | 21 + 140 part | 14 + 448 part | 23 + 138 part |
|            Unaligned length |      11749129 |      12391043 |      11861165 |      12428520 |
|         Genome fraction (%) |        87.711 |        88.030 |        87.635 |        87.977 |
|           Duplication ratio |         1.033 |         1.017 |         1.032 |         1.017 |
|    # mismatches per 100 kbp |        630.66 |        634.87 |        629.76 |        631.67 |
|        # indels per 100 kbp |        148.04 |        146.12 |        229.83 |        175.85 |
|           Largest alignment |       1314910 |       3020858 |       1314246 |       3020120 |
|        Total aligned length |     108406734 |     107149609 |     108218440 |     107087388 |
|                       NGA50 |        230832 |        498783 |        230692 |        498642 |
|                       NGA75 |         74558 |        108593 |         72928 |        108308 |
|                       LGA50 |           141 |            52 |           141 |            52 |
|                       LGA75 |           369 |           188 |           371 |           189 |


* How do your genome assemblies look according to your QUAST results? Is one genome assembly better than the other?
    * *I would say the flye assembly is better, since NG50 is much higher (polished: 8822047, raw: 8819554) than the one from the canu assembly (polished: 433815, raw: 433505). The also counts for the NG75 (flye: polished: 1705972, raw: 1705414; canu: polished: 211025, raw: 209127). But the LG50 and LG75 are both considerably smaller for the flye assembly than for the canu assembly.*
* What additional information you get if you have a reference available?
    * *We get information about missassemblies and unaligned contigs. Where the assemblies are either similar or again flye is much better.*

#### Assessing quality with merqury
* What are the consensus quality QV and error rate values of your assemblies?
    * *answer*
* What is the estimated completeness of your assemblies?
    * *answer*
* How does your copy-number spectra look like? Do they confirm the expected coverage?
    * *answer*
* Does one assembly perfom better than the other?
    * *answer*
