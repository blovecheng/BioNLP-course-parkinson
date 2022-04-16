diff_gene <- c(6622,120892,20617,161882,4137,6531,65018,2629,11315,1917) #输入显著基因列表
gene<-read.table("D:/gene.txt",sep = '\t')
##统计与显著基因出现在同一篇文献中的疾病
disease <- read.table("D:/disease.txt",sep = '\t')
tmp <- c()
#找出文献中出现的显著基因
for( i in diff_gene){
  
  tmp <- append(tmp,which(gene$V6 == i))
}#与ID相同的行数
tmp2 <- gene[tmp,]  #得到显著基因对应基因信息
pmid <- unique(tmp2$V1)  #得到去重后的pmid
tmp3 <- c()
#找出pmid对应的疾病
for (j in pmid) {
  tmp3 <- append(tmp3,which(disease$V1 == j))
}#disease中与gene相同的pmid
final_disease <- disease[tmp3,]
Freq_disease <- as.data.frame(table(final_disease$V4))  #统计出与显著基因存在于同一篇文献中的疾病的频次
sFreq_disease<-Freq_disease[order(Freq_disease$Freq,decreasing = T),]
write.table(sFreq_disease,file = "D:/sdisease.txt",sep = "\t")

##统计与显著基因出现在同一篇文献中的突变
mutation <- read.table("D:/mutation.txt",sep = '\t')
tmp4 <- c()
#找出pmid对应的突变
for (j in pmid) {
  tmp4 <- append(tmp4,which(mutation$V1 == j))
}
final_mutation <- mutation[tmp4,]
Freq_mutation <- as.data.frame(table(final_mutation$V4))  #统计出与显著基因存在于同一篇文献中的突变的频次
sFreq_mutation<-Freq_mutation[order(Freq_mutation$Freq,decreasing = T),]
write.table(sFreq_mutation,file = "D:/smutation.txt",sep = "\t")

##统计与显著基因出现在同一篇文献中的化合物
chemical<- read.table("D:/chemical.txt",sep = '\t')
tmp5 <- c()
#找出pmid对应的突变
for (j in pmid) {
  tmp5 <- append(tmp5,which(chemical$V1 == j))
}
final_chemical <- chemical[tmp5,]
Freq_chemical <- as.data.frame(table(final_chemical$V4))  #统计出与显著基因存在于同一篇文献中的突变的频次
sFreq_chemical<-Freq_chemical[order(Freq_chemical$Freq,decreasing = T),]
write.table(sFreq_chemical,file = "D:/schemical.txt",sep = "\t")

