#PBS -S /bin/bash
#PBS -q batch
#PBS -N BWA_align_and_Sort_BAM
#PBS -l nodes=1:ppn=4:AMD
#PBS -l walltime=72:00:00
#PBS -l mem=16gb
#PBS -M noahaus@uga.edu
#PBS -m abe

#cd $PBS_O_WORKDIR
OUT=output_dir
BAM=output_dir/BAM
BASIC=output_dir/BAM/basic
NODUP=output_dir/BAM/nodup
VCF=output_dir/VCF
FILTER=output_dir/VCF/filtered
PILEUP=output_dir/VCF/pileup
RAW=output_dir/VCF/raw
RAXML=output_dir/RAXML

mkdir $OUT $BAM $BASIC $NODUP $VCF $FILTER $PILEUP $RAW $RAXML

#module add BWA/0.7.17-foss-2016b
#module add SAMtools/1.9-foss-2016b
#module add picard/2.16.0-Java-1.8.0_144
#module add RAxML/8.2.11-foss-2016b-mpi-avx
#module add BCFtools/1.9-foss-2016b

#echo
#echo "Job ID: $PBS_JOBID"
#echo "Queue:  $PBS_QUEUE"
#echo "Cores:  $PBS_NP"
#echo "Nodes:  $(cat $PBS_NODEFILE | sort -u | tr '\n' ' ')"
#echo "mpirun: $(which mpirun)"
#echo

#python pairread2sortBAM.py NC_002945v4.fasta
#mv *.sorted.bam remove_duplicates.py -t $BASIC
#cd $BASIC

#python remove_duplicates.py
#mv *.nodup.sorted.bam -t $NODUP

#echo "BAM files created and duplicates removed" |  mail -s "$PBS_JOBID: BAM creation complete" noahaus@uga.edu

#ls | grep "nodup.sorted.bam" > bam_list.txt
#bcftools mpileup -Ou -f NC_002945v4.fasta -b bam_list.txt > temp.pileup.vcf
#bcftools call -Ou --ploidy 1 -mv temp.pileup.vcf > temp.raw.vcf
#bcftools filter -s LowQual -e '%QUAL<20 || TYPE="indel"' temp.raw.vcf > 53_isolates.filter.vcf
#python vcf2phylip.py -i 53_isolates.filter.vcf

#mkdir ../../vcf
#mkdir ../../vcf/filtered
#mkdir ../../vcf/pileup
#mkdir ../../vcf/raw
#mv 53_isolates.filter.* -t ../../vcf/filtered
#mv temp.pileup.vcf -t ../../vcf/pileup
#mv temp.raw.vcf -t ../../vcf/raw

#echo "variant calling completed" |  mail -s "$PBS_JOBID: variant calling done" noahaus@uga.edu

#cd ../../vcf/filtered
#mpirun raxmlHPC-MPI-AVX -s 53_isolates.filter.min4.phy -n 53_isolates -m GTRGAMMA -N 100 -p 1000
#mkdir ../../raxml
#mv *.53_isolates.*  *.53_isolates -t ../../raxml

#echo "Preliminary ML trees developed" |  mail -s "$PBS_JOBID: tree generation complete" noahaus@uga.edu
