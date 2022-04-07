#@author: 陈佳雨
#@date: 2022/04/06

from Bio import Entrez
handle = Entrez.esearch(db = "pubmed", term = "parkinson", retmax = "160000")
record = Entrez.read(handle)
n = int(record["Count"])

output = open("C:/Users/DELL/Desktop/BioNLP/parkinson_PMID.txt","wt")
for i in range(n):
    output.write(record["IdList"][i] + "\n")
output.close()
