%HaploGrep Optimisation - multimap.svg

library(reshape2)
library(ggplot2)

Samples <- c(1074, 2000,2534, 4534, 10000,20000,30561)
HaploGrep  <-c(37, 73, 92, 162, 353, 0, 0)
HaploGrep2 <- c(5.23,  7.45,  11.31,  18.22, 48.3, 95.69, 138.47)
MultiMap <- c(4.97,  6.83,   10.9,  17.04, 43.12, 80.89, 125.2)
nyx <- data.frame(Samples, HaploGrep, HaploGrep2, MultiMap)

nyxlong <- melt(nyx, id=c("Samples"))

%filter empty values
nyxnew<- nyxlong[nyxlong$value != 0.00,] 


ggplot(nyxnew, aes(x = Samples, y = value, color = variable) ) +     geom_point() + geom_line() +
    labs(x="\nNumber",y="Result\n") + scale_color_manual(values=c("#CC6666", "#9999CC" , "#99CC99" )) 
    
    
/////////////////////

library("gridExtra", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.2")

dat1 <- data.frame(
    Method = factor(c("HaploGrep2","HaploGrep2","HaploGrep2","MultiMap","MultiMap","MultiMap")),
    MicroArray = factor(c("Illumina","Affy6","23andMe","Illumina", "Affy6", "23andMe"), levels=c("Illumina", "Affy6", "23andMe")),
    time = c(9.94, 14.56, 65.4, 2.76,4.06,5.05)
)

p1 <- ggplot(data=dat1, aes(x=MicroArray, y=time, fill=Method)) +
    geom_bar(stat="identity", position=position_dodge() ) +
    scale_fill_manual(values=c("#9999CC", "#99CC99")) + theme(legend.position="bottom") + ylim(800)
    
dat2 <- data.frame(
    Method = factor(c("HaploGrep2","HaploGrep2","HaploGrep2","MultiMap","MultiMap","MultiMap")),
    MicroArray = factor(c("Illumina","Affy6","23andMe","Illumina", "Affy6", "23andMe"), levels=c("Illumina", "Affy6", "23andMe")),
    time = c(104, 182, 775, 26.54,40.99,47.27)
)

p2 <- ggplot(data=dat2, aes(x=MicroArray, y=time, fill=Method)) +
    geom_bar(stat="identity", position=position_dodge() ) +
    scale_fill_manual(values=c("#9999CC", "#99CC99")) + ggtitle("GenBank subset (n=12,503)") + theme(plot.title = element_text(hjust = 0.5))
    
g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}

mylegend<- g_legend(p1) 

p3 <- grid.arrange(arrangeGrob(p1 + theme(legend.position="none"),
                               p2 + theme(legend.position="none"),
                               nrow=1),
                   mylegend, nrow=2,heights=c(10, 1))

    
    