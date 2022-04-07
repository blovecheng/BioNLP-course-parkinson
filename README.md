# BioNLP-course-parkinson
《针对帕金森疾病的文献挖掘与知识发现》相关代码、信息

## 1、获取parkinson相关文献的PMID
```
from Bio import Entrez   #调包
handle = Entrez.esearch(db = "pubmed", term = "parkinson", retmax = "160000")
record = Entrez.read(handle)   #获取搜索结果
n = int(record["Count"])   #PMID号总数

output = open("C:/Users/DELL/Desktop/BioNLP/parkinson_PMID.txt","wt")
for i in range(n):
    output.write(record["IdList"][i] + "\n")   #将结果读入到文本文件中
output.close()
```
得到一个存储着104544个pmid号的文本文件parkinson_PMID.txt

## 2、获取文献标题摘要及实体信息
利用Python提供的第三方库requests模块通过PubTator进行提取得到结果文件，文件包含PMID号对应文献的标题、摘要和已被标注的实体信息。
