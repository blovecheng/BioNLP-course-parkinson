#@date:2022/05/02

InputFileName= "C:/Users/DELL/Desktop/BioNLP/data/parkinson_pubtator.txt"
File_source_pubtator = open(InputFileName,'r',encoding='utf-8')
Gene_Chemical = open("C:/Users/DELL/Desktop/BioNLP/data/gene_chemical.txt", 'a+', encoding='utf-8')

def filter_sent(keyword1,keyword2):    
    B_AnnPerArticle_dic = {}  #词典AnnPerArticle_dic，#句首字母off-set起始位作为Key， 标注多行结果作为Value。每读完一个Article，置空。
    B_E_SentPerArticle_list = []   #句子列表。每读完一个Article，置空。
                     #[{'begin': 0, 'end': 23, 'sent': 'Peutz-Jeghers Syndrome'}, 
                     #{'begin': 24, 'end': 232, 'sent': 'CLINICAL CHARACTERISTICS: Peutz-Jeghers bla bla.'}]
    FilteredSentCount = 0 #筛选出的句子的计数
    ArticleID = []
    for line in File_source_pubtator:

        #line处理Step-1: 对title的行的处理
        if line[8:11] == '|t|':
            title_for_print = line #title_for_print 用于保留打印
            title = line.strip().split('|t|')[-1]
            len_title = len(title)
            B_E_SentPerArticle_list.append({"begin":0,"end":len_title+1,"sent":title})
            #print(B_E_SentPerArticle_list)
            #exit(0)
            #[{'begin': 0, 'end': 23, 'sent': 'Peutz-Jeghers Syndrome'}]
            continue         

        #line处理Step-2: 对abstract行的处理
        if line[8:11] == '|a|':
            article = line.strip().split('|a|')[-1]
            sents = article.strip().split('. ') #依据句号分句
            start = len_title+2
            sent_start = []
            sent_end = []
            sent_start.append(start)
            for sent in sents:
                start = len(sent) + 2 +start
                sent_start.append(start)
                sent_end.append(start-1) 
                
            for i,s in enumerate(sent_start[0:-1]):
                B_E_SentPerArticle_list.append({"begin":s,"end":sent_end[i],"sent":sents[i] + '.'}) 
                
            continue   

        #line处理Step-3: #对多个标注行的处理            
        if len(line.strip().split('\t')) == 6:  #判断是否为标注行 
            B_AnnPerArticle_dic[line.strip().split('\t')[1]] = line  #off-set起始位置作为Key， 标注的多行结果作为Value， 建词典
            continue
           
        #line处理Step-4: 每读到空行+换行符，开始处理一篇摘要或者全文：把标注写入词典AnnPerSent_dic，
        if line == '\n': 
            Sent_AnnPerArticle_dic = {} #词典AnnPerSent_dic，Key为句子，Value为标注
            sent_annos = []  #定义一个列表，一一读取所有标注行。存入到AnnPerSent_dic后，写入报告文件File_report，再置空。
            for each_b_e_sent in B_E_SentPerArticle_list:
                for anno_start in B_AnnPerArticle_dic.keys():
                    if int(anno_start) >= int(each_b_e_sent["begin"]) and int(anno_start) < int(each_b_e_sent["end"]):
                        sent_annos.append(B_AnnPerArticle_dic[anno_start])               
                Sent_AnnPerArticle_dic[each_b_e_sent["sent"]] = sent_annos  #词典AnnPerSent_dic中，key为句子，Value为标注
                sent_annos = []
                      
            for each_sent in Sent_AnnPerArticle_dic.keys():
                if keyword1 in each_sent and keyword2 in each_sent:
                    for a in Sent_AnnPerArticle_dic[each_sent]:
                        ArticleID.append(a.strip().split('\t')[0])
                    FilteredSentCount = FilteredSentCount + 1       
            B_E_SentPerArticle_list = []
            B_AnnPerArticle_dic = {}

    if FilteredSentCount != 0:
        print('In total, {0} sentences are filtered from {1} articles,and the results are stored in {2}. Enjoy! \n'.format(FilteredSentCount, len(set(ArticleID)), OutputFileName))
        output = keyword1 + "\t" + keyword2 + "\t" + str(FilteredSentCount) + "\n"
        Gene_Chemical.write(output)

gene_name = []
with open("C:/Users/DELL/Desktop/BioNLP/data/六个实体/gene.txt",'r',encoding='utf-8') as file:
	gene = file.readlines()
	for line in gene:
		gname = line.strip().split("\t")[3]
		gene_name.append(gname)
gene_name = set(gene_name)
gene_name = list(gene_name)

chemical_name = []
with open("C:/Users/DELL/Desktop/BioNLP/data/六个实体/chemical.txt",'r',encoding='utf-8') as file:
	chemical = file.readlines()
	for line in chemical:
		cname = line.strip().split("\t")[3]
		chemical_name.append(cname)
chemical_name = set(chemical_name)
chemical_name = list(chemical_name)

for queryword1 in gene_name:
    for queryword2 in chemical_name:
        filter_sent(queryword1,queryword2)
Gene_Chemical.close()
