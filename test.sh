#PBS -S /bin/bash
#PBS -q batch
#PBS -N test
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime= 12:00:00
#PBS -l mem=4gb
#PBS -M noahaus@uga.edu
#PBS -m abe

echo "Hi! I'm a test"
