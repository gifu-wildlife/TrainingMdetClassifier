# 250530のデータセットから、トリガーIDをまとめた（層化した）上で3:1:1に分けた新しいデータセットを作る

# 加工前データの編集読み込み

library(tidyverse)

d <- read.csv("data/detector_output-annotation_data_250530.csv")
# head(d)

# crop_pathを分割し、セッションとカメラ番号とファイル名を引き出す。8番目セッション、9番目カメラ、10番目切り出し画像
add_data <- data.frame(session = rep(0,nrow(d)))
add_data$session <- sapply(d$crop_path %>% str_split(pattern="/"),function(x){x[8]})
add_data$camNo <- sapply(d$crop_path %>% str_split(pattern="/"),function(x){x[9]})
add_data$fname <- sapply(d$crop_path %>% str_split(pattern="/"),function(x){x[10]})

# クロップ画像の枝番(---*)を削除し、もとのファイル名にする。
rename_file <- function(filename) {
  gsub("---[0-9]\\.JPG$", ".JPG", filename)
}

add_data$ori_fname <- sapply(add_data$fname,rename_file)
# head(add_data)

# 元データを参照して撮影時刻データを引っこ抜いてくるために、sessionを確認
sessions <- add_data$session %>% unique

# Generate Object for original csv file data
all_ori_csv <- vector("list",length(sessions))
names(all_ori_csv) <- sessions

# 参照すべきネットワーク上のcsvのpathを作成



prefix_path <- file.path("//10.224.202.42/photodata/ensyurin",sessions,paste0(sessions,".csv"))

filename <- "mydata.csv"
cmd <- sprintf("smbclient //192.168.11.11/photodata -N -c 'get %s -'", filename)
df <- read.csv(pipe(cmd))


# その前にsmbで10.224.202.42/photodataをマウント
# 