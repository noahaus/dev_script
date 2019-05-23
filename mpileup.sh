#PBS -S /bin/bash
#PBS -q batch
#PBS -N mplieup_53isolates_Michigan
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=24:00:00
#PBS -l mem=4gb
#PBS -M noahaus@uga.edu
#PBS -m abe


cd $PBS_O_WORKDIR
module add SAMtools/1.9-foss-2016b

echo
echo "Job ID: $PBS_JOBID"
echo "Queue:  $PBS_QUEUE"
echo "Cores:  $PBS_NP"
echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
echo "mpirun: $(which mpirun)"
echo

samtools mpileup -g -f NC_002945v4.fasta -b nodup_bam_call.txt > 53_isolates_full_raw.bcf
