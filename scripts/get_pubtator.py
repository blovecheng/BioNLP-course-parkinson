import requests

with open("C:/Users/DELL/Desktop/BioNLP/parkinson_PMID.txt", "r") as file:
    pmids = [pmid.strip("\n") for pmid in file.readlines()]

out = open("C:/Users/DELL/Desktop/BioNLP/parkinson_pubtator.txt", "a+")
for pmid in pmids:
    data = requests.get("https://www.ncbi.nlm.nih.gov/research/pubtator-api/publications/export/pubtator?pmids=" + pmid)
    out.write(data.text)
out.close()
