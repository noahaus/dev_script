#PBS -S /bin/bash
#PBS -q batch
#PBS -N BWA_align_and_Sort_BAM
#PBS -l nodes=1:ppn=4:AMD
#PBS -l walltime=72:00:00
#PBS -l mem=16gb
#PBS -M noahaus@uga.edu
#PBS -m abe

cd $PBS_O_WORKDIR
module add BWA/0.7.17-foss-2016b
module add SAMtools/1.9-foss-2016b
module add picard/2.16.0-Java-1.8.0_144
module add RAxML/8.2.11-foss-2016b-mpi-avx


echo
echo "Job ID: $PBS_JOBID"
echo "Queue:  $PBS_QUEUE"
echo "Cores:  $PBS_NP"
echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
echo "mpirun: $(which mpirun)"
echo

mkdir output_dir
python pairread2sortBAM.py NC_002945v4.fasta
cd basic
cp NC_002945v4.fasta -t basic

python remove_duplicates.py
cd ../nodup

echo "BAM files created and duplicates removed" |  mail -s "$PBS_JOBID: BAM creation complete" noahaus@uga.edu

ls | grep "nodup.sorted.bam" > bam_list.txt
bcftools mpileup -Ou -f NC_002945v4.fasta -b bam_list.txt > temp.pileup.vcf
bcftools call -Ou --ploidy 1 -mv temp.pileup.vcf > temp.raw.vcf
bcftools filter -s LowQual -e '%QUAL<20 || TYPE="indel"' temp.raw.vcf > 53_isolates.filter.vcf
python vcf2phylip.py -i 53_isolates.filter.vcf

mkdir ../../vcf
mkdir ../../vcf/filtered
mkdir ../../vcf/pileup
mkdir ../../vcf/raw
mv 53_isolates.filter.* -t ../../vcf/filtered
mv temp.pileup.vcf -t ../../vcf/pileup
mv temp.raw.vcf -t ../../vcf/raw

echo "variant calling completed" |  mail -s "$PBS_JOBID: variant calling done" noahaus@uga.edu

cd ../../vcf/filtered
mpirun raxmlHPC-MPI-AVX -s 53_isolates.filter.min4.phy -n 53_isolates -m GTRGAMMA -N 100 -p 1000
mkdir ../../raxml
mv *.53_isolates.*  *.53_isolates -t ../../raxml

echo "Preliminary ML trees developed" |  mail -s "$PBS_JOBID: tree generation complete" noahaus@uga.edu
