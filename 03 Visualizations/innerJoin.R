df <- data.frame(dplyr::inner_join(baltimore, florida, by="CURRENT_ANNUAL_SALARY"))
df %>% select(POSITION_TITLE.y, CURRENT_ANNUAL_SALARY, GENDER) %>% ggplot(aes(x = POSITION_TITLE.y, y = CURRENT_ANNUAL_SALARY, color = GENDER)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + geom_point() + ggtitle("Annual Salary of Each Job's Position in 2014")
