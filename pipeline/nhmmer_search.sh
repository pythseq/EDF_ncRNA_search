#!/usr/bin/bash

#SBATCH --ntasks 32 --mem 24G --out logs/nhmmer.log -p short

CPUS=$SLURM_CPUS_ON_NODE
if [ -z $CPUS ]; then
	CPUS=1
fi
module load hmmer/3
module load parallel
for DB in db/*.hmm
do
	dbpref=$(basename $DB .hmm)
	parallel -j $CPUS nhmmer --dfamtblout results/${dbpref}-vs-{/.}.dfamtblout -o results/${dbpref}-vs-{/.}.nhmmer $DB {} ::: genomes/*.fasta
done
