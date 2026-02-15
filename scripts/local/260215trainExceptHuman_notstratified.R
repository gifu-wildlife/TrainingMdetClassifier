# 2026/2/15の層化しない方の学習

library(tidyverse)
# 元データ読み込み
d <- read.csv("data/detector_output-annotation_data_260213.csv")
head(d)

# いろいろあって、判読ミスを発見。
# ensyurin/kuraiyama201511/1507/PICT0394.JPGのcategory、cat_oriはraccoondogでなくboar
# ensyurin/kuraiyama201602/1504/PICT0945.JPGのcategory、cat_oriはbearでなくboar

d[grep(pattern="ensyurin-crop/kuraiyama201511/1507/PICT0394",d$crop_path),"category"] <- "boar"
d[grep(pattern="ensyurin-crop/kuraiyama201602/1504/PICT0945",d$crop_path),"category"] <- "boar"


# pathを入れ替える
# "/home/wildlife/TrainingMdetClassifier/"を差し替えるにする。
d$crop_path <- gsub(pattern="/home/wildlife/TrainingMdetClassifier/",replacement = "/home/ando/git/TrainingMdetClassifier/",d$crop_path)
head(d)

xtabs(~category,d)

#category
#      bear       bird       boar        cat       deer        fox     masked 
#       456        260       7373         40      18058        449         87 
#    monkey mustelidae     rabbit raccoondog      serow   squirrel 
#        19        431         51       1045       4150        190 

# 種別にlearning_phaseを適切数になるよう振り直す。

new_dset <- data.frame(learning_phase = d_addNo$No,
                        category = d_addNo$category,
                        crop_path = d_addNo$crop_path)
head(new_dset)

#データ数を確認
xtabs(~category+learning_phase,new_dset)
#            learning_phase
#category         0     1     2
#  bear         274    91    91
#  bird         156    52    52
#  boar        4425  1474  1474
#  cat           24     8     8
#  deer       10836  3611  3611
#  fox          270    90    89
#  masked        53    17    17
#  monkey        12     4     3
#  mustelidae   259    86    86
#  rabbit        31    10    10
#  raccoondog   627   209   209
#  serow       2490   830   830
#  squirrel     114    38    38

# data/に書き出す。
write.csv(new_dset,"data/detector_output-annotation_data_260215_notstratified.csv",row.names=FALSE)

