version 1.0

task QualityControl {
    input {
        File vcf_subset
        Float? R2 = 0.3  # Default minimum quality score
        Float? MAF = 0.001     # Estimated Minor Allele Frequency
    }

    command <<<
            bcftools view -i 'R2>${R2} & MAF>${MAF}' ~{vcf_subset} -o ~{vcf_subset}_filtered.vcf
    >>>

    output {
        File vcf_subset_QC = vcf_subset + "_filtered.vcf"
    }

    runtime {
        docker: "staphb/bcftools"
        memory: "16 GB"
        cpu: "4"
    }
}
