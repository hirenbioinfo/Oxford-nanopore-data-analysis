Welcome to the Oxford-nanopore-data-analysis wiki
Nanopore raw reads to final assembly with command line tools

This tutorial demonstrates how we can use oxford nanopore sequence reads to assemble a bacterial genome, including error correcting the assembly with short Illumina reads and genome circularization. Resources

Tools used in this tutorial:

canu v1.7
infoseq and sizeseq v6.6.0.0
circlator v1.5.1 	
bwa v0.7.15
samtools v1.3.1
spades v3.10.1
blast v2.4.0+
pilon v1.20
Steps:

1. Read and adapter trimming

Many users recommended to run adaptor and read trimming of Oxford Nanopore reads before run to any assembly. One recommend tool Porechop. This tool will trim adapters off read ends and split some chimeric reads, both of which make assembler job a little bit easier. Porechop also able to demultiplex barcoded reads, directly from Albacore output directory Example of basic adapter trimming:

porechop -i input_reads.fastq.gz -o output_reads.fastq.gz ----threads <40>

#Trimmed reads to stdout, if you prefer: porechop -i input_reads.fastq.gz > output_reads.fastq

For more detailed please have a look the link below.

Installation : https://github.com/rrwick/Porechop

Basic use : http://porecamp.github.io/2017/adapter_trimming.html.

Once you have per-process your raw reads you can run genome assembly.

2. Assembly :

Use Canu v1.7 (please note about the canu version according to developer, the latest version of canu work better for automatic plasmid rescue)

<your path where canu installed> canu -p ecoli -d E.coli-oxford genome Size=4.8m -nanopore-raw oxford.fasta

Output :

3. Assembly assessment:

Move into canu_out dir and ls to see the output files. The canu.contigs.fasta are the assembled sequences. The canu.unassembled.fasta are the reads that could not be assembled. The canu.correctedReads.fasta.gz are the corrected Nanopore reads that were used in the assembly. The canu.file.gfa is the graph of the assembly. after runnning assembly you will get a file “XXXXcontigs.fasta”, which is the final assembled output. In the output folder you can find assembly statistics also. Canu have many different option also such as you can change number of threads while running lummerland server. Please have a look all detailed in the link below. http://canu.readthedocs.io/en/latest/

4.Display summary information about the contigs:

(infoseq is a tool from EMBOSS)

infoseq canu.contigs.fasta

This will show the contigs found by Canu. e.g.,

tig00000001 49XXXXX This looks like a approximately 4.9 million bases, which is to be chromosome.
5. Error correction:

In the next step you need to run error correction with illumina reads.

bwa index contigs.fasta bwa mem -t 32 contigs.fasta illumina_R1.fastq.gz illumina_R2.fastq.gz | samtools sort > aln.bam samtools index aln.bam samtools faidx genome.fasta

pilon --genome genome.fasta --frags aln.bam --output pilon1 --fix all --mindepth 0.5 --changes --verbose --threads 32

6. Circularization:

Once you have run error correction last step is genome circularization. Here you can follow different steps. Manually or via command line tool. To do manually you need to run balstn(Query Sequence and subject sequence will be same) of final contigs. From blast result if you can look a end overlap the you need to cut that position and make the final cicular genome. Another approach could be by using Circlator. Here you need to run command line tool.

circlator all --threads 8 --verbose canu.contigs.fasta canu_outdir canu.correctedReads.fasta.gz circlator_outdir

output : You can find the output “Example: 04.merge.circularise.log”. Cirulator also oriented at your final genome according to dnaA.

Useful link
