# 히스토그램

hist(finedust$`3_ultrafine dust`, 
     main="서울시 서대문구 2020년 1월
초미세먼지 측정분포", 
     col=terrain.colors(12))



# 추세선? 추가함

lines(density(finedust$`3_ultrafine dust`), lwd=2)



# Boxplot 시각화
boxplot(finedust$`3_fine dust`, 
        main="야식업의 2020년 1월
미세먼지 발생현황", col="yellow")


# 두 개의 Boxplot을 비교 시각화하기
boxplot(finedust$`3_fine dust`, 
        finedust$`7_fine dust`, 
        main="업종별 2020년 1월 미세먼지
발생현황", col="yellow", names = 
          c("야식업","중식"))


# 3주차 미세먼지 산점도 추가


plot(x=finedust$`3_fine dust`, 
     y=finedust$`3_ultrafine dust`, 
     xlab="미세먼지", ylab="초미세먼지", 
     main="미세먼지와 초미세먼지의
변화")


# 산점도 시각화할 때, 노란색과 세모 모양으로 표시하기
plot(x=finedust$`3_fine dust`, 
     y=finedust$`3_ultrafine dust`, 
     xlab="미세먼지", ylab="초미세먼지", 
     main="미세먼지와 초미세먼지의
변화", pch=24, col="red", 
     bg="yellow", cex=1.5)


산점도의 그래프가 type에 따라서
어떻게 변하는지 확인
plot(x=finedust$`3_fine dust`, 
     y=finedust$`3_ultrafine dust`, 
     xlab="미세먼지", ylab="초미세먼지", 
     main="미세먼지와 초미세먼지의
변화", type = "h")
