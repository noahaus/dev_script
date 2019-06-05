#PBS -S /bin/bash
#PBS -q batch
#PBS -N vSNP_test
#PBS -l nodes=1:ppn=16:AMD
#PBS -l walltime=24:00:00
#PBS -l mem=10gb
#PBS -M noahaus@uga.edu
#PBS -m abe

module add Anaconda3/5.0.1
cd /scratch/noahaus/vSNP_53isolates/vSNP
source activate vsnp
cd ..
rm -r test_data
mkdir original_data test_data
cd 53_isolates_pairreads/
cp -r *.fastq.gz - t ../original_data
cp -r *.fastq.gz - t ../test_data
cd ../test_data
python ../vSNP/vSNP.py -d
echo "Step 1 of vSNP.py complete" | mail -s "vSNP: Step 1 status" noahaus@uga.edu
python ../vSNP/vSNP.py
echo "Step 2 of vSNP.py complete" | mail -s "vSNP: Step 2 status" noahaus@uga.edu
