queryAnalysis <- function() {
    
    library(dplyr)
    
    query1 <- read.table("query1.txt", header = TRUE, sep = ",")
    query2 <- read.table("query2.txt", header = TRUE, sep = ",")
    
    # select id and op.s columns
    columns <- c("id", "op.s")
    
    q1 <- select(query1, one_of(columns))
    q2 <- select(query2, one_of(columns))
    
    # generate a graph based on q1 and q2
    threads <- c(4, 8, 16, 24, 36, 54, 81, 121, 181, 271, 406, 609)
    range <- range(0, q1$op.s, q2$op.s)
    
    plot(q1$op.s, type = "o", col = "blue", ylim = range, axes = FALSE, ann = FALSE)
    axis(1, at = 1:12, labels = threads)
    axis(2, at = 2000*0:range[2])
    
    box()
    
    lines(q2$op.s, type = "o", col = "red", pch = 22, lty = 2)
    
    title(main = "Cassandra Stress Tool - Queries", col.main = "red", font.main = "4")
    title(xlab = "N of threads", col.lab = "red")
    title(ylab = "Queries per second", col.lab = "red")
    
    legend(10, 2000, c("query 1", "query 2"), cex = 0.8, col = c("blue", "red"), pch = 21:22, lty = 1:2)
}