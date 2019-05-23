#sortBAM2vcf.py
#author: Noah A. Legall
#date created: May 10th 2019
#date finished: May 10th 2019
#purpose: automates the process of creating a VCF file. all sorted bam files should exist in a folder

import sys # use to access arguments
import os # use in order to call commands from terminal script is called in


#use this python script in the directory you wish to analyze fastq files in

ref_genome = sys.argv[1].strip()

#index the reference genome
print("indexing "+ ref_genome)
os.system('samtools faidx '+ref_genome)


#separate the paired reads in the directory
os.system('ls | grep ".sorted.bam" > bam_call.txt')


#read in the R1.txt & R2.txt to variables R1 and R2 respectively
bam = open("bam_call.txt", "r")


bam_list = []



for line in bam:
    bam_list.append(line.strip())

input_string = ""
for i in range(len(bam_list)):
    input_string = input_string + bam_list[i]+" "

os.system("samtools mpileup -g -uf "+ref_genome+" -b bam_call.txt | bcftools view -")

#in the loop, we can now align each paired file to the reference genome fasta file.
for i in range(len(R1_list)):
    output_pre = R1_list[i].replace("_R1_001","")
    print("aligning "+output_pre.strip()+"files")
    os.system("bwa mem -t 4 "+ref_genome+" "+R1_list[i]+" "+R2_list[i]+" | samtools sort -@4 -o "+output_pre+".sorted.bam > output.quiet.log")
print("Sorted BAM files created and ready to be moved")
os.system("rm R_1.txt R_2.txt")
os.system("mkdir full_bam_output")
os.system("mv *.sorted.bam -t full_bam_output")


print("DONE")
