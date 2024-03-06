version 1.0

task AnnotateVariants {
    input {
        File vcf_subset_QC
        File vep_cache
        File genome_reference
        String file_label = "output"  # Simplified label for output files
        String vep_version = "release_110.1"  # Default VEP version
        Int vep_fork = 12  # Default number of forks for parallel processing
    }  

    command <<<
        set -euo pipefail

        ln -s ~{genome_reference} genome_reference.fasta

        if [ $(grep -v "#" ~{vcf_subset_QC} | wc -l) -eq 0 ]; then
            touch ~{file_label}_annotated_variants.vcf ~{file_label}_variants_vep_stats.txt
        else
            unzip ~{vep_cache} -d vep_cache/

            perl /opt/vep/src/ensembl-vep/vep --force_overwrite \
                --input_file ~{vcf_subset_QC} \
                --vcf \
                --output_file ~{file_label}_annotated_variants.vcf \
                --stats_file ~{file_label}_variants_vep_stats.txt \
                --stats_text \
                --cache \
                --dir_cache vep_cache/ \
                --fasta genome_reference.fasta \
                --fork ~{vep_fork} \
                --offline --hgvs --shift_hgvs 0 --terms SO --symbol \
                --sift b --polyphen b --total_length --ccds --canonical --biotype \
                --protein --xref_refseq --mane --pubmed --af --max_af --af_1kg --af_gnomadg \
                --custom file=vep_cache/clinvar.vcf.gz,short_name=ClinVar,format=vcf,type=exact,coords=0,fields=CLNSIG%CLNREVSTAT%CLNDN
        fi
    >>>

    output {
        File annotated_variants = "~{file_label}_annotated_variants.vcf"
        File variants_vep_stats = "~{file_label}_variants_vep_stats.txt"
    }

    runtime {
        docker: "ensemblorg/ensembl-vep:~{vep_version}"
        memory: "32G"
        disks: "local-disk 40 HDD"
    }
}