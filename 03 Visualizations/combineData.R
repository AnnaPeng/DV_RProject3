baltimore %>% select(CURRENT_ANNUAL_SALARY)
df2 <- data.frame(dplyr::bind_cols(florida, sample_n(baltimore, 9100)))
df2 %>% select(DEPARTMENT, GENDER) %>% filter(DEPARTMENT %in% c("POL", "HHS")) %>% ggplot(aes(x = DEPARTMENT)) + geom_bar() + facet_grid(.~GENDER)+ labs(x="Department", y= "Count") + ggtitle("Comparison DEPARTMENTS VS. GENDERS")