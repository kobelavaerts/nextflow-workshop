#!/usr/bin/env nextflow

// The input data is defined in the beginning.
params.samplesheet = "${launchDir}/exercises/03_first_pipeline/samplesheet.csv"
params.outdir = "${launchDir}/results"
params.threads = 2
params.slidingwindow = "SLIDINGWINDOW:4:15"
params.avgqual = "AVGQUAL:30"

include { fastqc as fastqc_raw; fastqc as fastqc_trim } from "../../modules/fastqc" 
include { trimmomatic } from "../../modules/trimmomatic"

// Running a workflow with the defined processes here.  
workflow {
    log.info """\
        LIST OF PARAMETERS
    ================================
                GENERAL
    Reads            : ${params.reads}
    Output-folder    : ${params.outdir}/

            TRIMMOMATIC
    Threads          : ${params.threads}
    Sliding window   : ${params.slidingwindow}
    Avg quality      : ${params.avgqual}
    """

    // Channels are being created. 
    def read_pairs_ch = channel.fromPath( params.samplesheet, checkIfExists: true )
        .splitCsv(header:true)
        .map{ row -> tuple( row.sample, [file(row.fastq_1), file(row.fastq_2)] ) }

    read_pairs_ch.view()
    fastqc_raw(read_pairs_ch) 
    trimmomatic(read_pairs_ch)
    fastqc_trim(trimmomatic.out.trim_fq)
}
