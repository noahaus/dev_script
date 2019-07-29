
import sys # use to access arguments
import os # use in order to call commands from terminal script is called in
from Bio import SeqIO

gbk = sys.argv[1].strip()
vcf_file = sys.argv[2].strip()
record = SeqIO.read(gbk, "gb")

os.system("touch isolate_annotation.txt")
out = open("isolate_annotation.txt","w")
out.write("SNPLocation\tFeatureList")
vcf = open(vcf_file,'r')
vcf_list = []
for line in vcf:
    if "##" in line:
        continue
    else:
        vcf_list.append(line)

feature_list = []
for f in record.features:
    feature_list.append("{} {} {}".format(str(f.qualifiers.get("gene")).replace("]","").replace("[","").replace("'",""),f.location.start,f.location.end))

for i in vcf_list:
    vcf_feat = i.split("\t")
    anno_string = ""
    gene_set = set()
    for j in feature_list:
        feature = j.split(" ")
        if(vcf_feat[1] > feature[1] and vcf_feat[1] < feature[2] and feature[0] != "None" and feature[0] not in gene_set):
            anno_string = anno_string + " {},".format( feature[0].strip())
            gene_set.add(feature[0].strip())
    out.write(vcf_feat[1] + " " + anno_string+"\n")

vcf.close()
out.close()
