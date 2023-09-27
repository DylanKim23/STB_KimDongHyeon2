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

barplot(table(X2023_STB_survey $Gender))

entry <- table(X2023_STB_survey $Gender, X2023_STB_survey $Grade)
barplot(entry, legend = TRUE)


# 8 Step : 파이차트 (Grade)
pie(table(X2023_STB_survey $Grade))


# 9 Step : 히스토그램1

hist(X2023_STB_survey$`Age`, main="히스토그램", col=terrain.colors(12))

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
plot(x=X2023_STB_survey$`Grade`, y=X2023_STB_survey$`Age`, xlab="Grade값", ylab="Age값", main="산점도")



plot(x=X2023_STB_survey$Grade, y=X2023_STB_survey$Age): 이 부분은 X2023_STB_survey 데이터프레임의 Grade 변수를 x-축으로, Age 변수를 y-축으로 사용하여 산점도를 그립니다. 산점도는 두 연속형 변수 간의 관계를 시각화하는데 사용됩니다. Grade 값이 x-축에 위치하고, Age 값이 y-축에 위치하며, 각 데이터 포인트는 해당 Grade와 Age의 조합을 나타냅니다.

xlab="Grade값": 이 부분은 x-축 레이블을 설정합니다. 그래프의 x-축에 "Grade값"이라는 레이블이 표시됩니다.

ylab="Age값": 이 부분은 y-축 레이블을 설정합니다. 그래프의 y-축에 "Age값"이라는 레이블이 표시됩니다.

main="산점도": 이 부분은 그래프의 제목을 설정합니다. 그래프의 제목은 "산점도"로 설정되며, 이것은 그래프의 주제를 나타내는 텍스트입니다.

코드의 목적은 학년(Grade)과 나이(Age) 간의 관계를 시각화하는 것입니다. 산점도는 데이터 포인트들을 점으로 표현하며, x-축과 y-축에 각 변수의 값을 매핑하여 두 변수 간의 관계를 파악할 수 있도록 도와줍니다. 이를 통해 학년과 나이 간의 관계 또는 분포를 시각적으로 확인할 수 있습니다.
