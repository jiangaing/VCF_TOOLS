# Variant Calling and Annotation from imputed genotype data
[![Open](https://img.shields.io/badge/Open-Dockstore-blue)](https://dockstore.org/workflows/github.com/jiangaing/VCF_TOOLS:main?tab=info)

> [!TIP]
> To import the workflow into your Terra workspace, click on the above Dockstore badge, and select 'Terra' from the 'Launch with' widget on the Dockstore workflow page.

## Workflow Steps

- **subsetVCF**: The variants in the VCF file are subgrouped based on the genomic regions

- **QualityControl**: The variants in the VCF file are filtered using bcftools view to include only variants that have passed all filters, and filters can be defined by user. 

- **AnnotateVariants**: The function are synchronized from ([source](https://https://github.com/anand-imcm/pb-variant-call?tab=readme-ov-file))


- ## Inputs
The main inputs to the workflow are:

- **required**
    - `vcf`: Input imputed genotype file in .vcf format.
    - `region`: Interested genomic regions. eg, "chr17:44345302-44353106" for GRN gene
    - `vep_cache` : VEP cache in .zip format. This [cache](https://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html#cache) is required by the `VEP` tool for annotation. The version being used is [Ensembl GRCh38 release v110](https://ftp.ensembl.org/pub/release-110/variation/vep/homo_sapiens_vep_110_GRCh38.tar.gz).
    filter parameters
    - `R2`: 0.3 "Estimated Imputation Accuracy (R-square)" # Default minimum accuracy score
    - `MAF`: 0.05 "Estimated Minor Allele Frequency" # Default minimum accuracy score
    - `genome_reference` : Human reference genome .fasta file. The version being used is GRCh38 release110 ([source](https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/))
- **optional** 

    - `AF`: ##INFO=<ID=AF,Number=1,Type=Float,Description= Estimated Alternate Allele Frequency>
    - `AF`: ##INFO=<ID=MAF,Number=1,Type=Float,Description="Estimated Minor Allele Frequency">
    - `AF`: ##INFO=<ID=R2,Number=1,Type=Float,Description="Estimated Imputation Accuracy (R-square)">
    - `ER2`: ##INFO=<ID=ER2,Number=1,Type=Float,Description="Empirical (Leave-One-Out) R-square (available only for genotyped variants)">
    - `IMPUTED`: ##INFO=<ID=IMPUTED,Number=0,Type=Flag,Description="Marker was imputed but NOT genotyped">
    - `TYPED`: ##INFO=<ID=TYPED,Number=0,Type=Flag,Description="Marker was genotyped AND imputed">
    - `TYPED_ONLY`: ##INFO=<ID=TYPED_ONLY,Number=0,Type=Flag,Description="Marker was genotyped but NOT imputed">

    - `GT`: ##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
    - `DS`: ##FORMAT=<ID=DS,Number=1,Type=Float,Description="Estimated Alternate Allele Dosage : [P(0/1)+2*P(1/1)]">
    - `HDS`: ##FORMAT=<ID=HDS,Number=2,Type=Float,Description="Estimated Haploid Alternate Allele Dosage">
    - `GP`: ##FORMAT=<ID=GP,Number=3,Type=Float,Description="Estimated Posterior Probabilities for Genotypes 0/0, 0/1 and 1/1">


- **raw_annotated_reference**: Human reference genome .gff file (General Feature Format). The version being used is GRCh38 release110 ([source](https://ftp.ensembl.org/pub/release-110/gff3/homo_sapiens/Homo_sapiens.GRCh38.110.gff3.gz)).

- ## Outputs

The main output files are listed below:

- **SortBam**:
  - `sorted_bam` :Sorted bam file
- **FeatureCount**:
   - `raw_count_file`: Text file containing raw gene expression count
 
## Components


- **Tools**
  - samtools
  - featureCounts
- **Containers**
  - pegi3s/samtools_bcftools
  - pegi3s/feature-counts
  - ensemblorg/ensembl-vep
 
 ## Acknowledgement

- Anand Maurya: [https://github.com/anand-imcm](https://github.com/anand-imcm)