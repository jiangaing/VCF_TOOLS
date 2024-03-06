version 1.0

import "./tasks/QualityControlVCF.wdl" as QualityControlVCF
import "./tasks/subsetVCF.wdl" as subsetVCF
import "./tasks/AnnotateVariants.wdl" as AnnotateVariants


workflow main {
    input {
        File vcf
        String? region = "chr1"
        Float? R2 = 0.3  # Default minimum quality score
        Float? MAF = 0.01 
        File vep_cache
        File genome_reference
    }

    call subsetVCF.subsetVCF {
        input: vcf = vcf, region = region
    }
    call QualityControlVCF.QualityControl {
        input: vcf_subset = subsetVCF.vcf_subset, minQual = minQual, minDepth = minDepth, minGQ = minGQ, maxAF = maxAF
    }
    call AnnotateVariants.AnnotateVariants {
        input: vcf_subset_QC = QualityControl.vcf_subset_QC, vep_cache = vep_cache, genome_reference = genome_reference, file_label = "final"
    }

    output {
        File vcf_subset = subsetVCF.vcf_subset
        File vcf_subset_QC = QualityControl.vcf_subset_QC
        File annotated_variants = AnnotateVariants.annotated_variants
        File variants_vep_stats = AnnotateVariants.variants_vep_stats
    }
    meta {
        description: "A WDL-based workflow for VCF file"
        author: "Chang"
        email: "jiang.chang@well.ox.ac.uk"
    }
}