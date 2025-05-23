#!/usr/bin/env nextflow

params.reads = "${launchDir}/data/*{1,2}.fq.gz"

/**
 * Quality control fastq
 */
    
process fastqc {
    container 'quay.io/biocontainers/fastqc:0.11.9--0'

    input:
    tuple val(sample), path(read)  
    
    script:
    """
    fastqc ${read}
    """
}

workflow {
    def reads_ch = Channel
        .fromFilePairs( params.reads, checkIfExists:true )
        .view()

    fastqc(reads_ch)
}