# Variant Calling and Annotation from imputed genotype data
[![Open](https://img.shields.io/badge/Open-Dockstore-blue)](https://dockstore.org/workflows/github.com/jiangaing/VCF_TOOLS:main?tab=info)

> [!TIP]
> To import the workflow into your Terra workspace, click on the above Dockstore badge, and select 'Terra' from the 'Launch with' widget on the Dockstore workflow page.

## Workflow Steps

- **subsetVCF**: The variants in the VCF file are subgrouped based on the genomic regions

- **Filter SNP**: The variants in the VCF file are filtered using bcftools view to include only variants that have passed all filters, and filters can be defined by user. 

- **AnnotateVariants**: The function are synchronized from ([source](https://https://github.com/anand-imcm/pb-variant-call?tab=readme-ov-file))


- ## Inputs
The main inputs to the workflow are:

- **required**
    - `vcf`: Input imputed genotype file in .vcf format.
    - `region`: Interested genomic regions. eg, "chr17:44345302-44353106" for GRN gene
    - `vep_cache` : VEP cache in .zip format. This [cache](https://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html#cache) is required by the `VEP` tool for annotation. The version being used is [Ensembl GRCh38 release v110](https://ftp.ensembl.org/pub/release-110/variation/vep/homo_sapiens_vep_110_GRCh38.tar.gz).
    - filter parameters
    - `R2`: 0.3 "Estimated Imputation Accuracy (R-square)" # Default minimum accuracy score
    - `MAF`: 0.05 "Estimated Minor Allele Frequency" # Default minimum accuracy score
    - `genome_reference` : Human reference genome .fasta file. The version being used is GRCh38 release110 ([source](https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/))
- **optional** 
    -from column INFO in VCF file
    - `AF`: Estimated Alternate Allele Frequency, Float,[0,1]
    - `MAF`: Estimated Minor Allele Frequency, Float,[0,1]
    - `R2`: Estimated Imputation Accuracy (R-square), Float,[0,1]
    - `ER2`: Empirical (Leave-One-Out) R-square (available only for genotyped variants), Float, [0,1]
    - `IMPUTED`: Marker was imputed but NOT genotyped, Flag, 0/1
    - `TYPED`: Marker was genotyped AND imputed, Flag, 0/1
    - `TYPED_ONLY`: Description="Marker was genotyped but NOT imputed, Flag, 0/1

    -from column FORMAT in VCF file
    - `GT`: Genotype, String, 0|0 or 1|0 or 1|1
    - `DS`: Estimated Alternate Allele Dosage, Float : [P(0/1)+2*P(1/1)]
    - `HDS`: Estimated Haploid Alternate Allele Dosage, Float, [0,1]
    - `GP`: Number=3,Type=Float,Description="Estimated Posterior Probabilities for Genotypes 0/0, 0/1, 1/1


- ## Outputs

The main output files are listed below:

- **subsetVCF**:
    - `vcf_subset` : Vcf file contains variant in input interested region
- **QualityControl**:
    - `vcf_subset_QC`: Vcf file contains variant in input interested region after filtering
- **AnnotateVariants**
    - `annotated_variants`: VCF file containing annotated variants.
    - `variants_vep_stats`: Statistics for annotated variants.



## Components

- **Containers**
  - staphb/bcftools
  - ensemblorg/ensembl-vep

 
 ## Acknowledgement
[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
- Anand Maurya: [https://github.com/anand-imcm](https://github.com/anand-imcm)
