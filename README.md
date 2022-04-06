# BioNLP-course-parkinson
《针对帕金森疾病的文献挖掘与知识发现》相关代码、信息

## 1、获取parkinson相关文献的PMID
```
from Bio import Entrez
handle = Entrez.esearch(db = "pubmed", term = "parkinson", retmax = "160000")
record = Entrez.read(handle)
n = int(record["Count"])

output = open("C:/Users/DELL/Desktop/BioNLP/parkinson_PMID.txt","wt")
for i in range(n):
    output.write(record["IdList"][i] + "\n")
output.close()
```
得到一个存储着104544个pmid号的文本文件

## 2、获取文献标题摘要及实体信息
利用老师上课讲到的shell脚本通过PubTator进行提取得到结果文件
