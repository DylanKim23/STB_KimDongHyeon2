


# 변수설정
response = c(2, 3, 4, 4, 5, 6, 6, 7, 8)
x = rep(c("model1", "model2", "model3"), c(3, 3, 3))
levels = factor(x)

# 분산분석 
ano.result = aov(response ~ levels)

# ANOVA 결과
summary(ano.result)
