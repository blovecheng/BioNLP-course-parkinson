# BioNLP-course-parkinson
《针对帕金森疾病的文献挖掘与知识发现》相关代码、信息

## 1、获取parkinson相关文献的PMID
```
from Bio import Entrez   # 调包
handle = Entrez.esearch(db = "pubmed", term = "parkinson", retmax = "160000")
record = Entrez.read(handle)   # 获取搜索结果
n = int(record["Count"])   # PMID号总数

output = open("C:/Users/DELL/Desktop/BioNLP/parkinson_PMID.txt","wt")
for i in range(n):
    output.write(record["IdList"][i] + "\n")   # 将结果读入到文本文件中
output.close()
```
得到一个存储着104544个pmid号的文本文件parkinson_PMID.txt,结果已上传到/data文件夹下

## 2、获取文献标题摘要及实体信息
利用Python提供的第三方库requests模块通过PubTator进行提取得到结果文件，文件包含PMID号对应文献的标题、摘要和已被标注的实体信息。
```
import requests   # 调包

with open("C:/Users/DELL/Desktop/BioNLP/parkinson_PMID.txt", "r") as file:
    pmids = [pmid.strip("\n") for pmid in file.readlines()]   # 将PMID号以列表形式储存

out = open("C:/Users/DELL/Desktop/BioNLP/parkinson_pubtator.txt", "a+")
for pmid in pmids:
    data = requests.get("https://www.ncbi.nlm.nih.gov/research/pubtator-api/publications/export/pubtator?pmids=" + pmid)   # 连接网站，抓取实体信息
    out.write(data.text)   # 输出抓取结果（标题、摘要、实体）
out.close()
```
*parkinson_pubtator.txt文件超过25M无法上传

## 3、分别提取摘要和实体信息
使用Linux命令对上一步获取的parkinson_pubtator.txt文件进行处理
```
grep -E "^[0-9]{8}\s" parkinson_pubtator.txt > entity.txt  # 提取实体数据
grep -E "^[0-9]{8}\|a" parkinson_pubtator.txt | sed -r "s/.{11}//" > abstract.txt   # 提取摘要数据
```
再从得到的实体文件entity.txt中分别提取出基因、疾病、化合物、突变、细胞系、物种六类实体信息
```
grep -E "\bGene\b" entity.txt  > gene.txt
grep -E "\bDisease\b" entity.txt  > disease.txt
grep -E "Mutation\b" entity.txt  > mutation.txt
grep -E "\bChemical\b" entity.txt  > chemical.txt
grep -E "\bCellLine\b" entity.txt  > cellline.txt
grep -E "\bSpecies\b" entity.txt  > species.txt
```
部分结果已上传到/data文件夹下

## 4、GO和KEGG富集分析
将基因实体文件中最后一列的ID号导入到DAVID数据库进行富集分析，导出的文件GO.txt和KEGG.txt已上传到/data文件夹下。在RStudio上编写代码完成可视化展示，对于GO富集结果分别取biological process、cellular component、molecule function富集基因数最多的前10项作柱状图并用不同颜色区分；对于KEGG富集结果取富集基因数最多的前20项作气泡图展示它的counts数以及可信度(pvalue)。最后使用RStudio的ggarange函数将两张图合并，结果存在/data/GO_KEGG.jpeg中。

## 5、计算词频并绘制词云图
#参考代码来源：https://github.com/kiekie233/BioNLP-course/blob/main/script/Get_entity_freq.R

参考代码并进行简化实现六种实体的词频计算并绘制出整体entity的词云图，修改过的代码放在/scripts文件夹下（wordcloud.r），结果上传到了/data文件夹下

## 6、基因、突变、疾病关联分析
#代码参考来源：https://github.com/HZYShadow/BioNLP-course-Covid-19/blob/main/bionlp_find.R

提取与出现次数最多的部分基因相关的突变和疾病并分析它们在帕金森疾病的发病机制中可能存在的作用与影响。

## 7、基因与化合物共句分析
这一步参考了学姐的代码，改写后的代码放在/scripts文件夹下（gene_chemical.py），获得的基因与化合物共句的结果也放在了/data下（gene_chemical.txt）

我们分别选择用所有的共句信息和共句次数前100的信息进行网络图绘制，最后发现使用前100的展示效果更好。
