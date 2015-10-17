require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")

# Change the USER and PASS below to be your UTEid
baltimore <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from BALTIMORE_EMPLOYEE_SALARIES14"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_bth679', PASS='orcl_bth679', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
summary(baltimore)
head(baltimore)

florida <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from EMPLOYEE_SALARIES_20142"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_bth679', PASS='orcl_bth679', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
summary(florida)
head(florida)

#Inner Join & Its Data Wrangling
df <- data.frame(dplyr::inner_join(baltimore, florida, by="CURRENT_ANNUAL_SALARY"))
df %>% select(POSITION_TITLE.y, CURRENT_ANNUAL_SALARY, GENDER) %>% ggplot(aes(x = POSITION_TITLE.y, y = CURRENT_ANNUAL_SALARY, color = GENDER)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + geom_point() + ggtitle("Annual Salary of Each Job's Position in 2014")
#Observations: 
#From this plot, we see that the job position that got the highest annual salary in 2014 was County Executive, which was approximately equal to $190,000. We also know that the Principal Administrative Aide position got the lowest annual salary. Overall, the average of annual salary that all jobs positions was about $65,000 to $70,000 and slightly differences between female and male, but nothing significant.



#Outer Join & Its Data Wrangling
df1 <- data.frame(dplyr::full_join(florida, baltimore, by="CURRENT_ANNUAL_SALARY"))
df1 %>% select(DEPARTMENT_NAME.x, GENDER, HIREDATE) %>% arrange(HIREDATE) %>% ggplot(aes(x = DEPARTMENT_NAME.x, y = as.character(as.numeric(HIREDATE)), color = GENDER)) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + geom_point() + labs(x="Department Name", y= "Hiring Date") + ggtitle("Amount of Employees got hired for each Department in 2014")
#Observations: 
#From this plot, we observe that the department that employees got hired the most in 2014 was states attorneys office, and most of them were female. Also, there are several department that not many employees got hired, which were FIN-Purchasing, Fire Department, COMP-Comptrollers O, Planning Department, and Liquor License Board.

#Combining data sets and its data wrangling
baltimore <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from BALTIMORE_EMPLOYEE_SALARIES14"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_bth679', PASS='orcl_bth679', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df2 <- data.frame(dplyr::bind_cols(florida, sample_n(baltimore, 9100)))

df2 %>% select(DEPARTMENT, GENDER) %>% filter(DEPARTMENT %in% c("POL", "HHS")) %>% ggplot(aes(x = DEPARTMENT)) + geom_bar() + facet_grid(.~GENDER)+ labs(x="Department", y= "Count") + ggtitle("Comparison DEPARTMENTS VS. GENDERS")
#Observation: 
#According to this plot, we can see that the department of health and human services tends to have more female than the department of police. And there are more male in department of police than the department of health and human services. It does makes sense to see this result because most of police's jobs are dangerous, so male fits better for these position. In the other hand, female can takes care for others better than male. So, this plot does give us a very accurate observation that we hoped for.


