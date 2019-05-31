#vcf_intersect.py
#author: Noah A. Legall
#date created: May 28th 2019
#date finished: May 28th 2019
#purpose: create an intersection file for all SNPs in a directory.

import os

os.system('ls | grep ".vcf" > v_list.txt')
vcf = open("v_list.txt", "r")
vcf_list = []

for line in vcf:
    vcf_list.append(line.strip())

for i in range(len(vcf_list)):
    vcf_string = vcf_string+vcf_list[i]+" "

os.system('bcftools isec -n='+len(vcf_list)+' '+vcf_string)
