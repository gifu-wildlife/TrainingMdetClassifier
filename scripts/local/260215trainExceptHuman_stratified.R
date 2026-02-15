# 2026/2/13の学習

library(tidyverse)
# 元データ読み込み
d <- read.csv("data/detector_output-annotation_data_260213.csv")
head(d)
xtabs(~category,d)
xtabs(~category+learning_phase,d)

# パスの守成
d$crop_path <- gsub(pattern="/home/wildlife/TrainingMdetClassifier/",replacement = "/home/ando/git/TrainingMdetClassifier/",d$crop_path)


new_dset <- data.frame(learning_phase = d$learning_phase,
                        category = d$category,
                        crop_path = d$crop_path)
head(new_dset)

#データ数を確認
xtabs(~category,new_dset)
#category
#       bat       bear       bird       boar        cat       deer        dog 
#         3        456        260       7373         40      18058          8 
#       fox      human     masked     monkey      mouse mustelidae     rabbit 
#       449       3436         87         19          1        431         51 
#raccoondog      serow   squirrel   unclearA 
#      1045       4150        190         50 

xtabs(~category+learning_phase,new_dset)
#                learning_phase
#category         0     1     2
#  bear         273    92    91
#  bird         155    52    53
#  boar        4425  1474  1474
#  cat           24     9     7
#  deer       10835  3612  3611
#  fox          271    89    89
#  masked        52    18    17
#  monkey        11     5     3
#  mustelidae   258    86    87
#  rabbit        30    10    11
#  raccoondog   628   210   207
#  serow       2491   830   829
#  squirrel     115    37    38

# data/に書き出す。
write.csv(new_dset,"data/detector_output-annotation_data_260215_stratified.csv")
