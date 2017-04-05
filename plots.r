%HaploGrep Optimisation - multimap.svg

library(reshape2)
library(ggplot2)

Samples <- c(1074, 2000,2534, 4534, 10000,20000,30561)
HaploGrep  <-c(37, 73, 92, 162, 0, 0, 0)
HaploGrep2 <- c(5.23,  7.45,  11.31,  18.22, 48.3, 95.69, 138.47)
MultiMap <- c(2.28,  3.28,   4.89,  7.92, 20.78, 40.05, 56.19)
nyx <- data.frame(Samples, HaploGrep, HaploGrep2, MultiMap)

nyxlong <- melt(nyx, id=c("Samples"))

%filter empty values
nyxnew<- nyxlong[nyxlong$value != 0.00,] 


ggplot(nyxnew, aes(x = Samples, y = value, color = variable) ) +     geom_point() + geom_line() +
    labs(x="\nNumber",y="Result\n") + scale_color_manual(values=c("#CC6666", "#9999CC" , "#99CC99" )) 