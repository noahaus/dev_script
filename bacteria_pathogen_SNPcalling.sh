#PBS -S /bin/bash
#PBS -q batch
#PBS -N BWA align and Sort BAM
#PBS -l nodes=1:ppn=4:AMD
#PBS -l walltime= 72:00:00
#PBS -l mem=16gb
#PBS -M noahaus@uga.edu
#PBS -m abe

cd $PBS_O_WORKDIR
module add BWA/0.7.17-foss-2016b
module add SAMtools/1.9-foss-2016b
module add picard/2.16.0-Java-1.8.0_144
module add freebayes/1.2.0

echo
echo "Job ID: $PBS_JOBID"
echo "Queue:  $PBS_QUEUE"
echo "Cores:  $PBS_NP"
echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
echo "mpirun: $(which mpirun)"
echo

python pairread2sortBAM.py NC_002945v4.fasta
cd full_bam_output
python remove_duplicates.py
cd full_nodup_bam_output
