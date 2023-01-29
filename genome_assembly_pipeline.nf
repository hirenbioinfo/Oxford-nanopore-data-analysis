#!/usr/bin/env nextflow
params.reads = 'path/to/reads/*.fastq.gz'
params.read_length_cutoff = 1000

process adapter_trimming {
  input:
    file reads from params.reads

  output:
    file trimmed_reads = 'results/trimmed/{sample}.fastq.gz'

  shell:
    'porechop -i $reads -o results/trimmed'
}

process read_filtering {
  input:
    file reads from adapter_trimming.trimmed_reads

  output:
    file filtered_reads = 'results/filtered/{sample}.fastq.gz'

  shell:
    'filtlong $reads --min_len $params.read_length_cutoff -o results/filtered'
}

process fastqc {
  input:
    file reads from read_filtering.filtered_reads

  output:
    file qc_results = 'results/fastqc/{sample}.html'

  shell:
    'fastqc $reads -o results/fastqc'
}

process genome_assembly {
  input:
    file reads from read_filtering.filtered_reads

  output:
    file assembly = 'results/assembly/{sample}.fasta'

  shell:
    'flye --nano-raw $reads -o results/assembly'
}

