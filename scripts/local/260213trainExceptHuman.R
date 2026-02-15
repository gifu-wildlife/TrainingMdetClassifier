# 2026/2/13の学習

library(tidyverse)
# 元データ読み込み
d <- read.csv("data/data_split_species_stratified_seed1234_260213.csv")
head(d)
xtabs(~category,d)
xtabs(~category+segment,d)

# まずpathを入れ替える
# "/home/data_ssd/photodata/"を"~/data/ensyurin_MachineLearning/"に差し替え
d$crop_path <- paste0("/home/wildlife/TrainingMdetClassifier/data/ensyurin_MachineLearning/",d$crop_path)
head(d)

d[d$segment=="train",]$segment <- 0
d[d$segment=="valid",]$segment <- 1
d[d$segment=="test",]$segment <- 2

new_dset <- data.frame(learning_phase = d$segment,
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

# 数が非常に少ないもの、分類対象外のものを外す。
# ここではbat, dissapear, dog, humanm, mouse, unclear_aをはずず

new_dset2 <- new_dset %>% filter(!(category %in% c("bat", "dog", "human", "mouse", "unclearA")))
nrow(new_dset2)
head(new_dset2)
xtabs(~category,new_dset2)
xtabs(~category+learning_phase,new_dset2)

# data/に書き出す。
write.csv(new_dset2,"data/detector_output-annotation_data_260213.csv")
