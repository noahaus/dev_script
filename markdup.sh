#PBS -S /bin/bash
#PBS -q batch
#PBS -N mark_duplicates
#PBS -l nodes=1:ppn=4:AMD
#PBS -l walltime=24:00:00
#PBS -l mem=4gb
#PBS -M noahaus@uga.edu
#PBS -m abe


cd $PBS_O_WORKDIR
module add picard/2.16.0-Java-1.8.0_144

echo
echo "Job ID: $PBS_JOBID"
echo "Queue:  $PBS_QUEUE"
echo "Cores:  $PBS_NP"
echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
echo "mpirun: $(which mpirun)"
echo

python remove_duplicates.py
