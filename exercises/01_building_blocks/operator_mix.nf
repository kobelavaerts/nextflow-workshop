#!/usr/bin/env nextflow

def c1 = channel.of( 1,2,3 )
def c2 = channel.of( 'a','b' )
def c3 = channel.of( 'z' )

c1.mix(c2,c3)
  .view()