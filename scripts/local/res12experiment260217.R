library(tidyverse)
d <- read_tsv("/home/ando/git/TrainingMdetClassifier/scripts/local/res12experiment260217.tsv")
d %>% data.frame %>% filter(split=="outertest")
