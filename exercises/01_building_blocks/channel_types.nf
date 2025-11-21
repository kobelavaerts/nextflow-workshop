#!/usr/bin/env nextflow

process foo {
  input:
  val x
  val y

  output:
  stdout

  script:
  """
  echo $x and $y
  """
}

workflow {
  def x = channel.of(1)
  def y = channel.of('a', 'b', 'c')
  foo(x, y)
  foo.out.view()
}