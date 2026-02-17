library(tidyverse)
# 元データ読み込み
d <- read.csv("/home/wildlife/TrainingMdetClassifier/data/ensyurin_MachineLearning/detector_output-annotation_data_250530.csv")
head(d)
xtabs(~category,d)
xtabs(~category+learning_phase,d)

# まずpathを入れ替える
# "/home/data_ssd/photodata/"を"~/data/ensyurin_MachineLearning/"に差し替え
new_path <- gsub("/home/data_ssd/photodata/","/home/wildlife/TrainingMdetClassifier/data/ensyurin_MachineLearning/",d$crop_path)

new_dset <- data.frame(learning_phase = d$learning_phase,
                        category = d$category,
                        path = new_path)
head(new_dset)

#データ数を確認
xtabs(~category,new_dset)
#category
#       bat       bear       bird       boar        cat       deer  dissapear 
#         3        457        260       7371         40      18058       1051 
#       dog        fox      human     masked     monkey      mouse mustelidae 
#         8        449       3436         87         19          1        431 
#    rabbit raccoondog      serow   squirrel  unclear_a 
#        51       1046       4150        190         50 

# 数が非常に少ないもの、分類対象外のものを外す。
# ここではbat, dissapear, dog, humanm, mouse, unclear_aをはずず

new_dset2 <- new_dset %>% filter(!(category %in% c("bat", "dissapear", "dog", "human", "mouse", "unclear_a")))
nrow(new_dset2)
head(new_dset2)
xtabs(~category,new_dset2)

#列名を学習向けに訂正
colnames(new_dset2)[3] <- "crop_path" 


# data/に書き出す。
write.csv(new_dset2,"data/detector_output-annotation_data_250530.csv")
