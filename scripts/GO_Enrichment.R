setwd("C:/Users/DELL/Desktop/BioNLP/data")
go <- read.table(file = "GO.txt", sep = "\t", header = T, quote = '')
go_si <- go[go$PValue < 0.05, ]
library(tidyr)
go_si <- separate(go_si, Term, sep = "~", into = c("ID", "Term"))
bp <- go_si[go_si$Category == "GOTERM_BP_DIRECT", ]
bp <- bp[order(bp$Count, decreasing = T), ]
BP <- bp[1:10, ]
cc <- go_si[go_si$Category == "GOTERM_CC_DIRECT", ]
cc <- cc[order(cc$Count, decreasing = T), ]
CC <- cc[1:10, ]
mf <- go_si[go_si$Category == "GOTERM_MF_DIRECT", ]
mf <- mf[order(mf$Count, decreasing = T), ]
MF <- mf[1:10, ]
GO <- rbind(BP, CC, MF)
GO$Category <- rep(c("biological_process","cellular_component","molecule_function"), each = 10)
COLS <- c("#66C3A5", "#8DA1CB", "#FD8D62")
library(ggplot2)
p <- ggplot(data = GO, aes(x = Term,y = Count, fill = Category)) + geom_bar(stat="identity", width=0.8) + coord_flip() +  xlab("GO term") + ylab("Gene counts") +scale_fill_manual(values = COLS)+ theme_test() + theme(axis.text = element_text(face = "bold", color = "gray50")) + labs(title = "GO Enrichment")
p
