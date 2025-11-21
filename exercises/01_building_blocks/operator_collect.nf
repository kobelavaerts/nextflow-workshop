#!/usr/bin/env nextflow

channel
    .of( 1, 2, 3, 4 )
    .collect()
    .view()
