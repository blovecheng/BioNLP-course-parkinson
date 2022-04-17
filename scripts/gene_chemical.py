import pandas as pd   #导入pandas库

with open('C:/Users/DELL/Desktop/BioNLP/data/abstract.txt', 'r', encoding = 'UTF-8') as file:
    abstract = file.read()   #读取abstract

gene = pd.read_csv('C:/Users/DELL/Desktop/BioNLP/data/gene.txt', delimiter = "\t", header = None)   #读取基因实体文件
chemical = pd.read_csv('C:/Users/DELL/Desktop/BioNLP/data/chemical.txt', delimiter = "\t", quoting = 3, header = None)   #读取化学分子实体文件

sentences = list()
sentences = abstract.split('.')   #按句号分割摘要文件，每一句话作为一个sentences列表的一个元素

relation = pd.DataFrame()   #创建一个数据框用于存储共句的基因、化合物以及它们共句的句子
relation_count = pd.DataFrame()   #创建了一数据框用于存储共句次数

for gene in gene[3]:
    for chemical in chemical[3]:
        for sentence in sentences:
            if (gene in sentence) and (chemical in sentence):
                relation = relation.append({'gene':gene, 'chemical':chemical, 'evidence': sentence}, ignore_index=True)
#计算基因与化合物的共句信息

relation.to_csv('C:/Users/DELL/Desktop/BioNLP/data/relation.csv', header = False, index = None)   #输出共句信息文件

relation_count = relation.drop(['evidence'], axis = 1)
relation_count['count'] = 1
relation_count = relation_count.groupby(['gene', 'chemical'])['count'].sum().reset_index().sort_values('count', ascending = False).reset_index(drop = True)
#计算基因与化合物的共句次数

relation_count.to_csv('C:/Users/DELL/Desktop/BioNLP/data/relation_count.csv', header = False, index = None)
#导出共句次数结果文件
