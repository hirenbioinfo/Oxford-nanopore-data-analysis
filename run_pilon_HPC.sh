#!/bin/bash
#SBATCH -c 8
#SBATCH --mem 65536
#SBATCH -p long
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de
# here starts your actual program call/computation
#
#echo "START TIME: " `date`

pilon --genome Canu_H1099.fasta --frags Canu_H1009.bam --output pilon1 --fix all --mindepth 0.5 --changes --verbose --threads 8

 










