#extract_isolates.py
#date created: May 2nd 2019
#date finished: May 2nd 2019
#author: Noah A. Legall
#purpose: to extract isolates in lslab folder in order to recreate figures in BEAST

import sys # use to access arguments
import os # use in order to call commands from terminal script is called in

#read in file name with isolates
filename = sys.argv[1]

#read from the input file
file = open(filename, "r")

for line in file:
    split_string = line.split('_')
    isolate_id = split_string[0]
    os.system('cp *'+isolate_id+'* -t ../53_isolates_pairreads')
