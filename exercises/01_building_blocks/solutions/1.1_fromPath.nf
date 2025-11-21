#!/usr/bin/env nextflow


// Create the channels
def strings_ch = channel.of('This', 'is', 'a', 'channel')
def csv_ch = channel.fromPath('data/*.csv')

// Inspect a channels contents with the operator .view()
strings_ch.view()
csv_ch.view()