# 2026/2/16の学習

library(tidyverse)
# 元データ読み込み
td <- read.csv("data/tddata_stratified_seed1234_260215.csv")
head(td)
xtabs(~category,d)
xtabs(~category+learning_phase,d)

# 古い学習データについて、Stratified、notStratifiedのデータセットをそれぞれ読み込み
d_nSt <- read.csv("data/detector_output-annotation_data_260215_notstratified.csv")
head(d_nSt)

d_St <- read.csv("data/detector_output-annotation_data_260215_stratified.csv")[,2:4]
head(d_St)

#　tdからStとnStのデータセットをそれぞれ作って結合
td_nSt <- data.frame(learning_phase=td$learnng_phase1,category=td$category,crop_path=td$crop_path)
td_St <- data.frame(learning_phase=td$learning_phase2,category=td$category,crop_path=td$crop_path)

d_nSt_260216 <- rbind(d_nSt,td_nSt)
head(d_nSt_260216,3)
tail(d_nSt_260216,3)
xtabs(~category+learning_phase,d_nSt_260216)
#            learning_phase
#category         0     1     2
#  bear         587   195   195
#  bird        1165   388   388
#  boar        9253  3083  3083
#  cat           97    32    32
#  deer       49224 16407 16407
#  fox          675   224   223
#  masked       239    78    78
#  monkey        37    12    11
#  mustelidae  1813   603   603
#  rabbit       779   259   259
#  raccoondog  2679   893   893
#  serow       5583  1861  1861
#  squirrel     688   229   229

d_St_260216 <- rbind(d_St,td_St)
head(d_St_260216,3)
tail(d_St_260216,3)
xtabs(~category+learning_phase,d_St_260216)
#            learning_phase
#category         0     1     2
#  bear         587   196   194
#  bird        1164   389   388
#  boar        9252  3084  3083
#  cat           96    35    30
#  deer       49221 16406 16411
#  fox          675   223   224
#  masked       238    79    78
#  monkey        37    13    10
#  mustelidae  1809   605   605
#  rabbit       779   258   260
#  raccoondog  2681   894   890
#  serow       5585  1860  1860
#  squirrel     688   229   229

# data/に書き出す。
write.csv(d_nSt_260216,"data/d_nSt_260216.csv",row.names=FALSE)
write.csv(d_St_260216,"data/d_St_260216.csv",row.names=FALSE)
