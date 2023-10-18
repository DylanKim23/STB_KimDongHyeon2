#07. degree of congesti.R


str(congestion)

#변수의 이상치와 결측치 확인하고 처리
 
summary(congestion)


#결측치 개수 확인


is.na(congestion)
sum(is.na(congestion))
colSums(is.na(congestion))


# 우선 호선별로 첫차/막차의
#시간대가 다르기 때문에 가장 빠른 기차와 늦은 기차의 결측치가 있는 행을 제거합니다.
#결측치가 있는 행을 제거한 새로운 데이터 프레임 생성
#6시 출발기차의 결측치를 제거

congestion1 <- congestion[!is.na(congestion$s0600),]
colSums(is.na(congestion1))


#23시 30분 출발기차의 결측치를 제거
congestion1 <- congestion1[!is.na(congestion1$s2330),]
colSums(is.na(congestion1))

#다음으로 남은 시간대는 결측치를 0으로 대체합니다.
#남은 결측치를 0으로 대체
congestion1[is.na(congestion1)] <- 0
colSums(is.na(congestion1))


 

#다음으로 이상치가 있는지 확인합니다.
#이상치 확인 
library(ggplot2)

ggplot(congestion1, aes(y=s0530)) + 
geom_boxplot()

summary(congestion1$s0530)

# 실행하면, 상자그림이랑 아래 통계량이 나옴.
#> summary(congestion1$s0530)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.00    6.30   10.70   14.68   18.90  109.00

#이번 과정에서 이상치를 별도의 처리를 하지 않습니다. 
#그 이유는 사용자들의 이용목적에 따라서 해당 수치가 나올 수 있기 때문에 이상치로 판단하지 않습니다.




# 1. 파생변수 만들기 
# 먼저 파생변수를 만들어 봅시다. 모든 시간대 혼잡도의 평균을 만들어 봅시다.
# 1.지하철역의 하루 평균 혼잡도
congestion1$day_mean <- rowMeans(congestion1[,c('s0530','s0600','s0630','s0700','s0730','s0800','s0830','s0900','s0930','s1000','s1030','s1100','s1130','s1200','s1230','s1300','s1330','s1400','s1430','s1500','s1530','s1600','s1630','s1700','s1730','s1800','s1830','s1900','s1930','s2000','s2030','s2100','s2130','s2200','s2230','s2300','s2330')])


 

 


# 세부과제2 시작 !!!!

#1.지하철역의 하루 평균 혼잡도
congestion$day_mean <- rowMeans(congestion[,c('s0530','s0600','s0630','s0700','s0730','s0800','s0830','s0900','s0930','s1000','s1030','s1100','s1130','s1200','s1230','s1300','s1330','s1400','s1430','s1500','s1530','s1600','s1630','s1700','s1730','s1800','s1830','s1900','s1930','s2000','s2030','s2100','s2130','s2200','s2230','s2300','s2330')])

#2. 지하철 호선별 하루 평균 혼잡도
library(dplyr)

# "line" 열을 기준으로 데이터프레임을 그룹화하고 각 그룹의 평균을 계산
congestion1 %>%
  group_by(line) %>%
  summarise(line_mean = mean(day_mean))


#3. 지하철 호선별 출근시간(07:00~09:00)대의 평균혼잡도


 

s0700_mean <- congestion1 %>%
  summarise(s0700_mean = mean(s0700, na.rm = TRUE))

s0730_mean <- congestion1 %>%
  summarise(s0730_mean = mean(s0730, na.rm = TRUE))

s0800_mean <- congestion1 %>%
  summarise(s0800_mean = mean(s0800, na.rm = TRUE))

s0830_mean <- congestion1 %>%
  summarise(s0830_mean = mean(s0830, na.rm = TRUE))

s0900_mean <- congestion1 %>%
  summarise(s0900_mean = mean(s0900, na.rm = TRUE))

total_mean <- (s0700_mean + s0730_mean + s0800_mean + s0830_mean + s0900_mean) / 5

total_mean   # 해서 27.01541

 

#→ 기술통계분석 결과를 포함합니다.
 
congestion1 %>%summary(s0700)  # s0700에 대한 기술통계량 구하기

a1 = c(congestion1$s0700, congestion1$s0730, congestion1$s0800, congestion1$s0830, congestion1$s0900)# 전범위 기술통계량구하기
summary(a1, na_rm=True)


#→ 평균혼잡도가 가장 높은 시간대를 막대그래프로 그리기
# 0700 ~ 0900까지 평균혼잡도가 가장 높은 시간대는 0800 이다.


v = c(18.7, 24.6,32.3,30.1,29.4)
barplot(v)
name = c('s0700','s0730','s0800','s0830','s0900')
barplot(v,names=name) # barplot(v~name)


# 3-3)


library(dplyr)

# 추가 열을 비교하기 위해 필요한 열 이름을 나열
columns_to_compare <- c("day_mean", "s0700", "s0730", "s0800", "s0830", "s0900")

# "congestion" 데이터 프레임을 이용하여 "line" 별로 열들을 비교
result <- congestion %>%
  group_by(line, station) %>%
  summarize(across(all_of(columns_to_compare), mean)) %>%
  arrange(desc(day_mean)) %>%
  head(4)

# 결과 출력
print(result)




# 4번

congestion %>% 
  mutate(s80_grade=ifelse(s0800<=80, "good", ifelse(s0800<=130, "normal", ifelse(s0800<=150, "caution", "bad"))))%>%  
  group_by(line, s80_grade) %>%
  summarise(n=n())%>%  mutate(total=sum(n), pct=round(n/total*100,1))%>%  
  filter(s80_grade=="caution")%>%  
  select(line, s80_grade,n,pct)%>%  arrange(desc(pct))  


# 5번 
s1800_mean <- congestion %>% summarise(s1800_mean = mean(s1800, na.rm = TRUE))
s1830_mean <- congestion %>% summarise(s1830_mean = mean(s1830, na.rm = TRUE))
s1900_mean <- congestion %>% summarise(s1900_mean = mean(s1900, na.rm = TRUE))
s1930_mean <- congestion %>% summarise(s1930_mean = mean(s1930, na.rm = TRUE))
s2000_mean <- congestion %>% summarise(s2000_mean = mean(s2000, na.rm = TRUE))

total_mean1 <- (s1800_mean$s1800_mean + s1830_mean$s1830_mean + s1900_mean$s1900_mean + s1930_mean$s1930_mean + s2000_mean$s2000_mean) / 5

total_mean1

#5-1 번 
a2 <- c(congestion$s1800, congestion$s1830, congestion$s1900, congestion$s1930, congestion$s2000)

summary(a2, na.rm = TRUE)


# 5-2 번

v = c(40.8,38.3,30.3,25.3,23.6)
barplot(v)
name = c('s1800','s1830','s1900','s1930','s2000')
barplot(v,names=name) # barplot(v~name)


# 5-3 번
library(dplyr)

# 추가 열을 비교하기 위해 필요한 열 이름을 나열
columns_to_compare <- c("day_mean", "s1800", "s1830", "s1900", "s1930", "s2000")

# "congestion" 데이터 프레임을 이용하여 "line" 별로 열들을 비교
result <- congestion %>%
  group_by(line, station) %>%
  summarize(across(all_of(columns_to_compare), mean)) %>%
  arrange(desc(day_mean)) %>%
  head(4)
print(result)


# 6번 
congestion %>% 
  mutate(s80_grade=ifelse(s0800<=80, "good", ifelse(s0800<=130, "normal", ifelse(s0800<=150, "caution", "bad"))))%>%  
  group_by(line, s80_grade) %>%
  summarise(n=n())%>%  mutate(total=sum(n), pct=round(n/total*100,1))%>%  
  filter(s80_grade=="caution")%>%  
  select(line, s80_grade,n,pct)%>%  arrange(desc(pct))  





