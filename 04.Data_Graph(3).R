# 2 Step : 도수분포표
table(X2023_STB_survey$Gender)


# 3 Step : 상대도수분포표
a <- table(X2023_STB_survey$Gender)
prop.table(a)


# 4 Step : 교차표

table(X2023_STB_survey$Gender, X2023_STB_survey $Grade)

 



# 5 Step : 막대그래프 (Nationality)

barplot(table(X2023_STB_survey $Nationality))

entry <- table(X2023_STB_survey $Nationality, X2023_STB_survey $Nationality)
barplot(entry, legend = TRUE)

# 6 Step : (가로)막대그래프 
barplot(table(X2023_STB_survey $'residential area'),col=pal1, xlab= "지역", ylab= "빈도", xlim=c(0,50), horiz=TRUE)

        

# 7 Step : 막대그래프 (Gender와 Grade) 

barplot(table(X2023_STB_survey$Gender, X2023_STB_survey$Grade), legend = TRUE)


# 8 Step : 파이차트 (Grade)
pie(table(X2023_STB_survey $Grade))


# 9 Step : 히스토그램1

<<<<<<< HEAD
hist(X2023_STB_survey$`Age`, main="Frequency Distribution of Respondents' Ages", col=terrain.colors(12))
=======
hist(X2023_STB_survey$`Age`, main="Frequency Distribution of Respondents' Age", col=terrain.colors(12))
>>>>>>> 708d91042d5f784a3520690a75bb3108bf7c72c7

# 10 Step : BoxPlot Comparison, 기술통계


boxplot(X2023_STB_survey$`Grade`, X2023_STB_survey$`Age`, main="BoxPlot Comparison", col="yellow", names = c("Grade","Age"))

#summary(X2023_STB_survey, na.rm=T)
#Gender         Age            Grade        Nationality    residential area
#Min.   :1.0   Min.   :19.00   Min.   :2.000   Min.   :3.000   Min.   : 6.000  
#1st Qu.:1.0   1st Qu.:21.00   1st Qu.:2.000   1st Qu.:3.000   1st Qu.: 6.000  
#Median :1.5   Median :22.00   Median :3.000   Median :3.000   Median : 6.000  
#Mean   :1.5   Mean   :22.52   Mean   :3.125   Mean   :3.438   Mean   : 6.479  
#3rd Qu.:2.0   3rd Qu.:23.25   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.: 6.000  
#Max.   :2.0   Max.   :27.00   Max.   :4.000   Max.   :5.000   Max.   :11.000  



# 11 Step : Scatter Plot
plot(x=X2023_STB_survey$`Grade`, y=X2023_STB_survey$`Age`, xlab="Grade값", ylab="Age값", main="산점도",pch=24, col="red", bg="yellow", cex=1.5)

 
