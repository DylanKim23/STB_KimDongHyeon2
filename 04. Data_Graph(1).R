colors <- c("red", "orange", 
            "yellow", "green", "blue")
pie(table(KOTRA2023 
          $투자형태), col=colors, 
    main="해외진출기업의 투자형태")

install.packages("RColorBrewer")
library(RColorBrewer)

display.brewer.all()


pal1 <- brewer.pal(5, 'Set3’)
pie(table(KOTRA2023 
$투자형태), col=pal1, 
main="해외진출기업의 투자형태")

barplot(table(KOTRA2023 
$진출대륙명),col=pal1, xlab = 
"진출대륙명", ylab = "진출기업수", 
ylim=c(0,10000))



bp <- barplot(table(KOTRA2023 
$진출대륙명),col=pal1, xlab = 
"진출대륙명", ylab = "진출기업수", 
ylim=c(0,10000))

entry <-
c(333,828,9154,104,716,444,3
74)


text(x=bp, y=entry, labels=entry, 
pos=3)

barplot(table(KOTRA2023 
$진출대륙명),col=pal1, xlab = 
"진출대륙명", ylab = "진출기업수", 
xlim=c(0,10000), horiz=TRUE)

