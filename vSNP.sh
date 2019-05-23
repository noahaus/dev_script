#PBS -S /bin/bash
#PBS -q batch
#PBS -N vSNP_test
#PBS -l nodes=1:ppn=16:AMD
#PBS -l walltime= 24:00:00
#PBS -l mem=4gb
#PBS -M noahaus@uga.edu
#PBS -m abe

cd /scratch/noahaus/53_isolates_pairreads/vSNP_test/53_isolates_pairreads
module add Anaconda3/5.0.1
source activate vsnp
python ../../vSNP-master/vSNP.py
