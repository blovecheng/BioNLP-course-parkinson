#@author: 吴欣然
#@date: 2022/04/12
#参考代码来源：https://github.com/kiekie233/BioNLP-course/blob/main/script/Get_entity_freq.R

#entity
install.packages("wordcloud2")
library(wordcloud2)
data = read.csv('D:/data/entity.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
entity = data.frame(entity = data$V4, bioconcep = data$V5)
entity_list = c(entity$entity) 
freq = table(entity_list)
freq = data.frame(freq)
names(freq)[1] = "entity"
freq$entity = as.character(freq$entity)
freq$Freq = as.integer(freq$Freq)
freq = freq[!duplicated(freq$entity), ]
order_temp = order(freq$Freq, decreasing = T)
freq = freq[order_temp,]
wordcloud2(freq,size=0.7,fontFamily = '微软雅黑',color = 'random-light',shuffle = TRUE)

del <- which(freq$entity == "patients")
a <- freq[-del,]
del2 <- which(a$entity == "PD")
b <- a[-del2,]
del3 <- which(b$entity == "Parkinson's disease")
c <- b[-del3,]
wordcloud2(c,size=0.7,fontFamily = '微软雅黑',color = 'random-dark',shuffle = TRUE)

#gene
data = read.csv('D:/data/gene.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
gene = data.frame(nameg=data$V4,GENE=data$V5)
nameg_list = c(gene$nameg)
freqg = table(nameg_list)
freqg = data.frame(freqg)
names(freqg)[1] = "name"
freqg$name = as.character(freqg$name)#向量转换成字符串
freqg$Freq = as.integer(freqg$Freq)#转为整数
freqg = freqg[!duplicated(freqg$name), ]#去除重复向量
order_temp = order(freqg$Freq, decreasing = T)
freqg = freqg[order_temp,]

#disease
data = read.csv('D:/data/disease.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
disease = data.frame(named=data$V4,Disease=data$V5)
named_list = c(disease$named)
freqd = table(named_list)
freqd = data.frame(freqd)
names(freqd)[1] = "name"
freqd$Freq = as.integer(freqd$Freq)
freqd$name = as.character(freqd$name)
freqd = freqd[!duplicated(freqd$name), ]
order_temp = order(freqd$Freq, decreasing = T)
freqd = freqd[order_temp,]

#species
data = read.csv('D:/data/species.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
species = data.frame(names=data$V4,Species=data$V5)
names_list = c(species$names)
freqs = table(names_list)
freqs = data.frame(freqs)
names(freqs)[1] = "name"
freqs$name = as.character(freqs$name)
freqs$Freq = as.integer(freqs$Freq)
freqs = freqs[!duplicated(freqs$name), ]
order_temp = order(freqs$Freq, decreasing = T)
freqs = freqs[order_temp,]

#mutation
data = read.csv('D:/data/mutation.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
mutation = data.frame(namem=data$V4,Mutation=data$V5)
namem_list = c(mutation$namem)
freqm = table(namem_list)
freqm = data.frame(freqm)
names(freqm)[1] = "name"
freqm$name = as.character(freqm$name)
freqm$Freq = as.integer(freqm$Freq)
freqm = freqm[!duplicated(freqm$name), ]
order_temp = order(freqm$Freq, decreasing = T)
freqm = freqm[order_temp,]

#chemical
data = read.csv('D:/data/chemical.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
chemical = data.frame(namec=data$V4,Chemical=data$V5)
namec_list = c(chemical$namec)
freqc = table(namec_list)
freqc = data.frame(freqc)
names(freqc)[1] = "name"
freqc$name = as.character(freqc$name)
freqc$Freq = as.integer(freqc$Freq)
freqc = freqc[!duplicated(freqc$name), ]
order_temp = order(freqc$Freq, decreasing = T)
freqc = freqc[order_temp,]

#celline
data = read.csv('D:/data/cellline.txt', sep = "\t", header = F, stringsAsFactors = F, quote = "")
cellline = data.frame(namel=data$V4,Cellline=data$V5)
namel_list = c(cellline$namel)
freql = table(namel_list)
freql = data.frame(freql)
names(freql)[1] = "name"
freql$name = as.character(freql$name)
freql$Freq = as.integer(freql$Freq)
freql = freql[!duplicated(freql$name), ]
order_temp = order(freql$Freq, decreasing = T)
freql = freql[order_temp,]

