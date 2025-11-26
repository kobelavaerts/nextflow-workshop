#!/usr/bin/env nextflow

// Import the star indexing and alignment processes from the modules
// ...

// General parameters
params.datadir = "${launchDir}/data"
params.outdir = "${launchDir}/results"

// Input parameters
params.samplesheet = "${launchDir}/exercises/03_first_pipeline/samplesheet.csv"
params.genome = "${params.datadir}/ggal_1_48850000_49020000.Ggal71.500bpflank.fa"
params.gtf = "${params.datadir}/ggal_1_48850000_49020000.bed.gff"

// Trimmomatic
params.slidingwindow = "SLIDINGWINDOW:4:15"
params.avgqual = "AVGQUAL:30"

// Star
params.threads = 2
params.genomeSAindexNbases = 10
params.lengthreads = 98

include { fastqc as fastqc_raw; fastqc as fastqc_trim } from "../../modules/fastqc" //addParams(OUTPUT: fastqcOutputFolder)
include { trimmomatic } from "../../modules/trimmomatic"

// Running a workflow with the defined processes here.  
workflow {
    log.info """\
        LIST OF PARAMETERS
    ================================
                GENERAL
    Data-folder      : ${params.datadir}
    Results-folder   : ${params.outdir}
    ================================
        INPUT & REFERENCES 
    Input-files      : ${params.reads}
    Reference genome : ${params.genome}
    GTF-file         : ${params.gtf}
    ================================
            TRIMMOMATIC
    Sliding window   : ${params.slidingwindow}
    Average quality  : ${params.avgqual}
    ================================
                STAR
    Length-reads     : ${params.lengthreads}
    SAindexNbases    : ${params.genomeSAindexNbases}
    ================================
    """
    // Also channels are being created. 
    def read_pairs_ch = channel.fromPath( params.samplesheet, checkIfExists: true )
        .splitCsv(header:true)
        .map{ row -> tuple( row.sample, [file(row.fastq_1), file(row.fastq_2)] ) }

    // Define the channels for the genome and reference file
    // ...

    // QC on raw reads
    fastqc_raw(read_pairs_ch) 
        
    // Trimming & QC
    trimmomatic(read_pairs_ch)
    fastqc_trim(trimmomatic.out.trim_fq)
        
    // Mapping
    // ... 
    // ... 
    
    // Multi QC
    
}