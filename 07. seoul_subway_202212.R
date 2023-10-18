# 07. seoul_subway_202212.R       # ddd

install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)


# csv 형식의 파일 불러와서 subway 객체에 입력하고 구조 확인
str(subway)

# 변수의 이상치와 결측치 확인하고 처리
summary(subway)
# NA's(결측치)가 미표시됨.
#좌측 하단의 console창에
#NA's(결측치)가 표시되지 않았으니
#결측치는 없습니다.


# summary(subway) 출력시 ,getting_off의 최소값이 0이다?
# 최소갑싱 0이면, 내린사람이 없다는 의미임.
# 즉, 이상치가 없다.
# 포인트는 유료 승객임. 무임승차 인원은 필요x



#파생변수1.정수형day변수

subway$day <-
  substr(subway$Date,7,8)
 

class(subway$day)


subway$day <-
  as.integer(subway$day)



#파생변수2.line변수
table(subway$Line)
 

#조회결과 9호선과 9호선 2~3단계가
#구분되어 있기 때문에 이를 통합해
#주는 작업을 진행합니다. 아래
#명령어를 실행해 봅시다


subway$Line <-
  ifelse(subway$Line=="9호선2~3
         단계","9호선",subway$Line)

#파생변수3.station변수
table(subway$Station)





# 승하차 승객수의 합을 1개의 데이터로 만드는 작업
#파생변수4.총승하차승객수 total_passenger

subway$total_passenger <- subway$on_board+subway$getting_off



#분석데이터 최종 확인
str(subway)



### 과제 시작 ###
# 2) (개인 PBL 활동) 실습과정 – 세부과제 1
# ③ 수도권 지하철의 유료 승객 이용실태 분석
# 1. 지하철역의 하루 평균 승차/하차 승객수
# 2. 승차승객수가 가장 많았던 역의 노선을 찾아보기
# 3. 역별 하루 평균 전체 승객수 분석 // 총승하차승객수(total_passenger)
# 4. 역별 일평균 전체승객수 상위 10개 역을 막대그래프로 작성 // 역명(station)
# 5. 일별 전체승객 분석 // 총승하차승객수(total_passenger)
# 6. 특정 line 분석(1호선) // 총승하차승객수(total_passenger)
# 7. 노선별 전체승객 비율 비교
# 8. 지하철 전체 승객 비율 막대그래프 그리기
# 9. 일별 전체승객 선그래프 그리기 // 일자 데이터(day), 총승하차승객수(total_passenger)




# 1. 전체 노선에서 1개 역의 하루평균 승차, 하차 승객수 알아보기.
#1.지하철역의 하루 평균 승차/하차승객수


subway%>% 
  summarise(on_m=mean(on_board), off_m=mean(getting_off))

# 1번 결과값 이렇게 나옴.
# A tibble: 1 x 2
#on_m  off_m
#<dbl>  <dbl>
#  1 10966. 10925.



#2. 승차승객이 가장 많은 역을 찾아서
#요일, 노선, 역 이름, 승차승객수만 출력
max(subway$on_board)



# 2번 결과값 이렇게 나옴
#<dbl> <chr> <chr>             <dbl>
#  1 20221216 2호선 잠실(송파구청)    94732

# 2번 승차승객수가가장많았던역의노선을찾아보기 
subway%>% 
  filter(on_board==94732)%>% 
  select(Date, Line, Station, on_board)




# 3. 역별하루평균전체승객수분석
# passenger10에 입력하고 상위 3개역을 확인해 봅시다.

passenger10 <- subway %>%
  group_by(Station)%>%
  summarise(m=mean(total_passenger))%>%
  arrange(desc(m))%>%
  head(10)


head(passenger10,10)

# 3번 결과값. 어떤 station이 가장 빈도가 높나?
# = 강남


#Station              m
#<chr>            <dbl>
#  1 강남           148890.
#2 삼성(무역센터) 109113.
#3 구로디지털단지 108253.
#4 잠실(송파구청)        99594.
#5 역삼                  96873.
#6 을지로입구            93221.
#7 서울대입구(관악구청)  88757 
#8 영등포                87883.
#9 용산                  83246.
#10 성수                  77292.






# 2) 승차승객수가가장많았던역의노선을찾아보기
subway%>% 
  filter(on_board==94732)%>% 
  select(Date, Line, Station, on_board)



# 4. 역별 일평균 전체승객수 상위 10개 역을 막대그래프로 작성 
# 앞서 만들어 놓은 passenger10을이용하여 막대 그래프를 그려봅시다. 오늘은 ggplot 패키지를 이용하여작성합니다. 아래 # 명령어를 실행해봅시다.

# 아래 명령어 실행하면 가로 막대 그래프 추출됨
ggplot(data=passenger10, aes(x=reorder(Station, m), y=m))+
  geom_col()+
  coord_flip()  # 이게 가로로 변형해주는 코드임.


# 5번 일별전체승객분석
#12월 중에 전체 승객이 가장 많았던 날짜 3개 찾아서 날짜와 전체 수만 출력해 봅시다

subway %>%
  group_by(Date) %>% 
  summarise(total=sum(total_passenger)) %>%
  arrange(desc(total)) %>%
  head(3)

# 5번 결과값
#Date    total
#<dbl>    <dbl>
# 1 20221221 15699271
# 2 20221216 15695660
# 3 20221209 15623399


#Q. 일자별 승하차 인원은 우리나라 국민 대비/수도권 인구 대비 어느정도인가요?
 

# 6번 : 특정 line 분석(1호선)

subway %>%
  filter(Line=="1호선") %>%
  filter(total_passenger==max(total_passenger)) %>%
  select(Date, Station, on_board, getting_off, total_passenger)

# 6번 결과값
#Date Station on_board getting_off total_passenger
#<dbl> <chr>      <dbl>       <dbl>           <dbl>
#  1 20221216 서울역     59873       58758          118631



#Q. 어떤날 어느역의 이용자 수가 많았나요? 이유가 무엇일까요?


# 7번 : 노선별 전체승객 비율 비교


line_pct <- subway %>%
  group_by(Line) %>% 
  summarise(total=sum(total_passenger)) %>%
  mutate(all=sum(total), pct=round(total/all*100,2))


line_pct %>%
  arrange(desc(pct)) %>%
  head(3)


# 7번 결과값
#Line     total       all   pct
#<chr>    <dbl>     <dbl> <dbl>
#1 2호선 83322218 411586147  20.2 
#2 5호선 38034569 411586147  9.24
#3 7호선 34038397 411586147  8.27


Q. 어떤 호선을 가장 많이 이용했나요?
  


# 8번 : 지하철 전체 승객 비율 막대그래프 그리기
#  앞에서 구한 line_pct데이터를 이용하여 지하철 1~9호선, 분당선의 이용승객 운행 비율을 소수점 한자리까지 구하고 # 막대그래프를 그려봅시다. 

  line_pct10 <- line_pct %>%
  filter(Line%in%c("1호선","2호선","3호선","4호선","5호선","6호선","7호선","8호선","9호선","분당선" ))
ggplot(data = line_pct10, aes(x=reorder(Line,pct),y=pct))+
  geom_col()+
  coord_flip()+
  ggtitle("수도권 지하철 노선별 이용비율")+
  xlab("노선")+
  ylab("이용비율")

# 위에 출력시 막대그래프로 나옴.



# 9번 : 일별 전체승객 선그래프 그리기 // 일자 데이터(day), 총승하차승객수(total_passenger)

line_graph <- subway %>%
  group_by(day) %>%
  summarise(s=sum(total_passenger))
ggplot(data = line_graph, aes(x=day, y=s, group=1))+
  geom_line()+
  ggtitle("수도권 지하철 일별 이용승객수")+
  xlab("일")+
  ylab("이용승객")

# 위에 출력시 선그래프 나옴


 










