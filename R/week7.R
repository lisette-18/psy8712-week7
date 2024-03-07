#Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)



#Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv") %>%
  mutate(timeStart = ymd_hms(timeStart)) %>% #convert timeStart
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control"))) %>% #condition
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female"))) %>% #gender
  mutate(timeSpent = timeEnd - timeStart) %>% #convert timeSpent
  filter(q6 == 1) %>% #q6 <- subset(q6 == 1) #responded 1 to question 6
  select(-q6) #drop q6 overall