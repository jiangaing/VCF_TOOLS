version 1.0

task QualityControl {
    input {
        File vcf_subset
        Float? R2 = 0.3  # Default minimum quality score
        Float? MAF = 0.001 
        String region = "chr1"     # Estimated Minor Allele Frequency
    }

    command <<<Í
            bcftools view -i "R2>~{R2} & MAF>~{MAF}" ~{vcf_subset} -o ~{region}_filtered.vcf
    >>>

    output {
        File vcf_subset_QC = region + "_filtered.vcf"
    }

    runtime {
        docker: "staphb/bcftools"
        memory: "16 GB"
        cpu: "4"
    }
}
