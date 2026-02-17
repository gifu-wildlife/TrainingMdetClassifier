# 2026/2/16の学習

library(tidyverse)
# StとnStの元データ読み込み
nSt <- read.csv("data/d_nSt_260216.csv")
head(nSt)
xtabs(~category,nSt)

St <- read.csv("data/d_St_260216.csv")
head(St)
xtabs(~category,St)
#category
#      bear       bird       boar        cat       deer        fox     masked 
#       977       1941      15419        161      82038       1122        395 
#    monkey mustelidae     rabbit raccoondog      serow   squirrel 
#        60       3019       1297       4465       9305       1146 


# キャップをかける関数
set.seed(42)
cap_all_overrepresented <- function(df,
                                     class_col = "category",
                                     phase_col = "learning_phase",
                                     train_value = 0,
                                     cap = 2000) {
  
  df_out <- df
  
  # trainデータの行番号
  train_idx <- which(df_out[[phase_col]] == train_value)
  
  # train内のクラス分布
  train_classes <- df_out[[class_col]][train_idx]
  class_counts <- table(train_classes)
  
  # capを超えているクラス
  over_classes <- names(class_counts[class_counts > cap])
  
  # 各超過クラスを処理
  for (cls in over_classes) {
    
    idx_cls <- train_idx[df_out[[class_col]][train_idx] == cls]
    
    # 残す行
    keep_idx <- sample(idx_cls, cap)
    
    # 間引く行
    drop_idx <- setdiff(idx_cls, keep_idx)
    
    # learning_phase を NA に変更
    df_out[[phase_col]][drop_idx] <- NA
  }
  
  return(df_out)
}

# trainのデータを3000、validとtestとを1000でcapしたcsvを作成
set.seed(42)
nSt_cap <- cap_all_overrepresented(nSt, cap = 3000)
nSt_cap <- cap_all_overrepresented(nSt_cap, train_value = 1, cap = 1000)
nSt_cap <- cap_all_overrepresented(nSt_cap, train_value = 2, cap = 1000)
xtabs(~category+learning_phase,nSt_cap)
#            learning_phase
#category        0    1    2
#  bear        587  195  195
#  bird       1165  388  388
#  boar       3000 1000 1000
#  cat          97   32   32
#  deer       3000 1000 1000
#  fox         675  224  223
#  masked      239   78   78
#  monkey       37   12   11
#  mustelidae 1813  603  603
#  rabbit      779  259  259
#  raccoondog 2679  893  893
#  serow      3000 1000 1000
#  squirrel    688  229  229

set.seed(43)
St_cap <- cap_all_overrepresented(St, cap = 3000)
St_cap <- cap_all_overrepresented(St_cap, train_value = 1, cap = 1000)
St_cap <- cap_all_overrepresented(St_cap, train_value = 2, cap = 1000)
xtabs(~category+learning_phase,St_cap)
#            learning_phase
#category        0    1    2
#  bear        587  196  194
#  bird       1164  389  388
#  boar       3000 1000 1000
#  cat          96   35   30
#  deer       3000 1000 1000
#  fox         675  223  224
#  masked      238   79   78
#  monkey       37   13   10
#  mustelidae 1809  605  605
#  rabbit      779  258  260
#  raccoondog 2681  894  890
#  serow      3000 1000 1000
#  squirrel    688  229  229

# data/に書き出す。
write.csv(nSt_cap,"data/d_nSt_cap_260216.csv",row.names=FALSE)
write.csv(St_cap,"data/d_St_cap_260216.csv",row.names=FALSE)
