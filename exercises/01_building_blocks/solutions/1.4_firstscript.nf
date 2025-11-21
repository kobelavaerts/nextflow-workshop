#!/usr/bin/env nextflow

// Some comment

/**
 * Some 
 * longer
 * comment
 */

// Defining the process that is executed
process valuesToFile {
    tag "$nums,$strs" 	

    input: 
    val nums
    val strs
    
    output:
    path 'result.txt'
    
    script:
    """
    echo $nums and $strs > result.txt
    """
}

// Running a workflow with the defined processes  
workflow {
    // Creating a channel
    def numbers_ch = channel.of(1,2,3)
    def strings_ch = channel.of('a','b')

    valuesToFile(numbers_ch, strings_ch)
}

