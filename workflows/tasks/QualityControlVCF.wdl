version 1.0


task QualityControl {
    input {
        File vcf_subset
        Float minQual = 20.0  # Default minimum quality score
        Int minDepth = 10     # Default minimum depth of coverage
        Int minGQ = 30        # Default minimum genotype quality
        Float maxAF = 0.05    # Default maximum allele frequency
    }

    command <<<
            bcftools view -i 'QUAL>${minQual} & DP>${minDepth} & GQ>${minGQ} & AF<${maxAF}' ~{vcf_subset} -o ~{vcf_subset}_filtered.vcf
    >>>

    output {
        File vcf_subset_QC = "~{vcf_subset}_filtered.vcf"
    }

    runtime {
        docker: "staphb/bcftools"
        memory: "16 GB"
        cpu: "4"
    }
}
