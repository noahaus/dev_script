#variant_call.py
#author: Noah A. Legall
#date created: May 21st 2019
#date finished: May 21st 2019
#purpose: automates the process of calling SNPs


import sys # use to access arguments
import os # use in order to call commands from terminal script is called in

#read in the R1.txt & R2.txt to variables R1 and R2 respectively
os.system('ls | grep "bam" > b_list.txt')
bam = open("b_list.txt", "r")
bam_list = []

for line in bam:
    bam_list.append(line.strip())

#remove the duplicates one by one
for i in range(len(bam_list)):
    output = bam_list[i].replace(".nodup.sorted.bam",".vcf")
    os.system("freebayes -v "+ output+" -f NC_002945v4.fasta -u -p 1 -q 30 "+bam_list[i])


print("VCF files created and ready to be moved")
os.system("mkdir full_vcf_output")
os.system("mv *vcf -t full_vcf_output")

print("DONE")
