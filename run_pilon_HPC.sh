#!/bin/bash
#SBATCH --job-name=Prokka assembly 
#SBATCH --nodes= 8
#SBATCH --mem 65536
#SBATCH -p long
#SBaTCh --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=hig18@dsmz.de
# here starts your actual program call/computation
#

start_time=$(date +%s)
echo "Initial time " $start_time

pilon --genome Canu_H1099.fasta --frags Canu_H1009.bam --output pilon1 --fix all --mindepth 0.5 --changes --verbose --threads 8

stop_time=$(date +%s)
echo "Final time " $stop_time
execution_time=$(expr $stop_time - $start_time)
echo -e "Execution time " $execution_time " seconds \n "
echo -e "\t \t" $(($execution_time/60)) " minutes \n"
echo -e "\t \t" $(($execution_time/3600)) " hours \n"









