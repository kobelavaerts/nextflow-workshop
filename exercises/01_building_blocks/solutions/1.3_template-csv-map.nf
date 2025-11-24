#!/usr/bin/env nextflow

// Create the channels
def samples_ch = channel
                .fromPath('exercises/01_building_blocks/input.csv')
                .splitCsv(header:true)

// Inspect a channels contents with the operator .view()
samples_ch.view()
samples_ch.view{ row -> tuple(row.boardgame, row.release_year) }


// Define new channels and use map operator to extract specific columns
def boardgame_ch = samples_ch.map{ row -> row.boardgame }
def release_ch = samples_ch.map{ row -> row.release_year }
def tuple_ch = samples_ch.map{ row -> tuple(row.boardgame, row.release_year) }

// View contents of new channels
boardgame_ch.view()
release_ch.view()
tuple_ch.view()
