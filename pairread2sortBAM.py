#pairread2sortBAM.py
#author: Noah A. Legall
#date created: May 9th 2019
#date finished: May 10th 2019
#dates edited: May 21st 2019,
#purpose: automates the process of aligning multiple isolates to a reference genomeself. Will output a directory of sorted BAM files

import sys # use to access arguments
import os # use in order to call commands from terminal script is called in


#use this python script in the directory you wish to analyze fastq files in

ref_genome = sys.argv[1].strip()

#index the reference genome
print("indexing "+ ref_genome)
os.system('bwa index '+ref_genome)

#gunzip everything in the temp_folder
print("unzipping files if needed")
os.system('gunzip -r ./')
print("files unzipped")

#separate the paired reads in the directory
os.system('ls | grep "R1" > R_1.txt')
os.system('ls | grep "R2" > R_2.txt')

#read in the R1.txt & R2.txt to variables R1 and R2 respectively
R1 = open("R_1.txt", "r")
R2 = open("R_2.txt", "r")

R1_list = []
R2_list = []


for R1_line in R1:
    R1_list.append(R1_line.strip())

for R2_line in R2:
    R2_list.append(R2_line.strip())



#in the loop, we can now align each paired read file individually to the reference genome fasta file.
for i in range(len(R1_list)):
    output_pre = R1_list[i].replace("_R1_001","")
    print("aligning "+output_pre.strip()+"files")
    os.system("bwa mem -M -t 4 "+ref_genome+" "+R1_list[i]+" "+R2_list[i]+" | samtools sort -@4 -o "+output_pre+".sorted.bam > output.quiet.log")

print("Sorted BAM files created and ready to be moved")
os.system("rm R_1.txt R_2.txt output.quiet.log")
os.system("mkdir full_bam_output")
os.system("mv *.sorted.bam -t full_bam_output")


print("DONE")
