library(ggplot2)
library(ggpubr)
set.seed(13)
mexp = NULL
lambda = 0.2
for (i in 1 : 1000){
        mexp = c(mexp, mean(rexp(40,lambda)))
}
sample_mean <- mean(mexp) ; setNames(c(sample_mean, 1/lambda),c("Sample Mean", "Theorical Mean"))
sample_variance <- var(mexp); setNames(c(sample_variance, (1/lambda)^2/40),c("Sample Variance", "Theorical Variance"))
data1 <- data.frame(name = c("Sample Mean", "Theorical Mean"), value = c(sample_mean, 1/lambda))
ggplot() + aes(mexp) + geom_histogram(aes (y = ..density..),binwidth = 0.1, fill = "dodgerblue", color = "White") + 
        geom_vline(data = data1, mapping = aes(xintercept = value, color = c("Sample_Mean", "Theorical_Mean")), linetype = "dashed", size = 1) +
        stat_function(fun = dnorm, aes(color = "Normal_Distribution"), args = list(mean = mean(mexp), sd = sd(mexp)), size = 1) +
        scale_color_manual(name = "Legend", values = c(Sample_Mean = "red", Theorical_Mean = "black", Normal_Distribution = "green"))


Part2

data <- ToothGrowth
data$dose <- as.factor(data$dose)
head(data)
summary(data)

p <- ggplot(data = data, aes(x = supp, y = len ))
p + geom_boxplot(aes(fill=supp)) +  facet_wrap( ~ dose, scales = "free")

#Comparacion len por tipo de suplemento

t1 <- t.test(len ~ supp, data = data[data$dose == 0.5,], paired = FALSE, var.equal = TRUE)
sprintf("T Value = %n", t1$statistic)
t2 <-t.test(len ~ supp, data = data[data$dose == 1,], paired = FALSE, var.equal = TRUE)
t3 <-t.test(len ~ supp, data = data[data$dose == 2,], paired = FALSE, var.equal = TRUE)


t4 <-t.test(len ~ dose, data = data[data$supp == "VC" & (data$dose == 0.5 | data$dose == 1),], paired = FALSE, var.equal = TRUE)
t5 <-t.test(len ~ dose, data = data[data$supp == "VC" & (data$dose == 0.5 | data$dose == 2),], paired = FALSE, var.equal = TRUE)
t6 <-t.test(len ~ dose, data = data[data$supp == "VC" & (data$dose == 1 | data$dose == 2),], paired = FALSE, var.equal = TRUE)

t7 <-t.test(len ~ dose, data = data[data$supp == "OJ" & (data$dose == 0.5 | data$dose == 1),], paired = FALSE, var.equal = TRUE)
t8 <-t.test(len ~ dose, data = data[data$supp == "OJ" & (data$dose == 0.5 | data$dose == 2),], paired = FALSE, var.equal = TRUE)
t9 <-t.test(len ~ dose, data = data[data$supp == "OJ" & (data$dose == 1 | data$dose == 2),], paired = FALSE, var.equal = TRUE)
