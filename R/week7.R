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





#Visualization
week7_tbl %>%
  select(q1:q10) %>%
  ggpairs
(ggplot(week7_tbl, aes(x=timeStart, y = q1)) +
  geom_point() +
  labs(x="Date of Experiment", y = "Q1 Score")) %>%
  ggsave("../figs/fig1.png",.)


(ggplot(week7_tbl, aes(x = q1, y = q2, color = gender)) +
  geom_jitter() +
  labs(x="q1", y = "q2", color = "Participant Gender")) %>%
  ggsave("../figs/fig2.png",.)

(ggplot(week7_tbl, aes(x = q1, y = q2)) +
  geom_jitter() +
  facet_grid(cols=vars(gender)) +
  labs(x = "Score on Q1", y = "Score on Q2")) %>%
  ggsave("../figs/fig3.png",.)


(ggplot(week7_tbl, aes(x = gender, y = timeSpent))+
  geom_boxplot() +
  labs(x = "Gender", y = "Time Elapsed (mins)")) %>%
  ggsave("../figs/fig4.png",.)


(ggplot(week7_tbl, aes(x=q5, y = q7, color = condition)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = FALSE) + 
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition") + 
  theme(legend.position = "bottom",legend.background= element_rect(fill = "#E0E0E0"))) %>%
  ggsave("../figs/fig5.png",.)