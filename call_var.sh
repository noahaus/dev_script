#PBS -S /bin/bash
#PBS -q batch
#PBS -N call_variants
#PBS -l nodes=1:ppn=4:AMD
#PBS -l walltime=72:00:00
#PBS -l mem=4gb
#PBS -M noahaus@uga.edu
#PBS -m abe


cd $PBS_O_WORKDIR
module add BCFtools/1.9-foss-2016b

echo
echo "Job ID: $PBS_JOBID"
echo "Queue:  $PBS_QUEUE"
echo "Cores:  $PBS_NP"
echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
echo "mpirun: $(which mpirun)"
echo

ls | grep "nodup.sorted.bam" > bam_list.txt


bcftools mpileup -Ou -f NC_002945v4.fasta -b bam_list.txt > temp.raw.vcf
bcftools call -Ou --ploidy 1 -mv temp.raw.vcf > temp.call.vcf
bcftools filter -s LowQual -e '%QUAL<20 || TYPE="indel"' temp.call.vcf > 53_isolates.filter.vcf
python vcf2phylip.py -i 53_isolates.filter.vcf

mkdir full_vcf_output
mv 53_isolates.filter* -t full_vcf_output
