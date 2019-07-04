#!/bin/bash
#SBATCH -c 32
#SBATCH -p long
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de
# here starts your actual program call/computation
#
for F in *.fasta; do 
  N=$(basename $F .fasta) ; 
  prokka --locustag $N --outdir $N --prefix $N  $F ; 
done
