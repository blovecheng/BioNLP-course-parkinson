setwd("C:/Users/DELL/Desktop/BioNLP/data")
kegg <- read.table(file = "KEGG.txt", sep = "\t", header = T, quote = '')
kegg <- kegg[kegg$PValue < 0.05, ]
library(tidyr)
kegg <- separate(kegg, Term, sep = ":", into = c("ID", "Term"))
keggQ <- kegg[order(kegg$Count, decreasing = T), ]
KEGG <- keggQ[1:20, ]
library(ggplot2)
bubble <- ggplot(KEGG, aes(X.,Term)) + geom_point(aes(size = Count, color = -log10(PValue))) + scale_colour_gradient(low = "blue", high = "red") + theme_test(base_size = 10, base_rect_size = 1) + labs(x = "rich factor", y = "KEGG pathway", title = "KEGG Enrichment")
bubble
