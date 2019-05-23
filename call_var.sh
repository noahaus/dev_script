#PBS -S /bin/bash
#PBS -q batch
#PBS -N call_variants
#PBS -l nodes=1:ppn=4:AMD
#PBS -l walltime=24:00:00
#PBS -l mem=4gb
#PBS -M noahaus@uga.edu
#PBS -m abe


cd $PBS_O_WORKDIR
module add freebayes/1.2.0

echo
echo "Job ID: $PBS_JOBID"
echo "Queue:  $PBS_QUEUE"
echo "Cores:  $PBS_NP"
echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
echo "mpirun: $(which mpirun)"
echo

python variant_call.py
