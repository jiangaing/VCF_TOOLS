version 1.0

task subsetVCF {
    input {
        File vcf
        String region = "chr1"  # Default region set to chromosome 1
    }


    command <<<
        bcftools index ~{vcf}
        bcftools view -r ~{region} ~{vcf} -o ~{region}_subset.vcf
    >>>

    output {
            File vcf_subset = region + "_subset.vcf"
    }

    runtime {
        docker: "staphb/bcftools"
        memory: "16 GB"
        cpu: "4"
    }
}

