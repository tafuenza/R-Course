library(ggplot2)
library(car)
library(corrplot)
library(psych)
data("mtcars")
head(mtcars)
{mtcars$cyl <- as.factor(mtcars$cyl); mtcars$vs <- as.factor(mtcars$vs); mtcars$am <- as.factor(mtcars$am)}

{g <- ggplot(aes(x = am, y = mpg), data = mtcars)
        g <- g + geom_boxplot(aes(fill = am)) + labs( title = "MPG by transmission type", x = "Transmission Type", y = "MPG")
        g <- g + scale_fill_discrete(name = "Transmission \n Type", labels = c("Manual", "Automatic"))
        g <- g + theme(plot.title = element_text(hjust = 0.5)) ; g}

ggpairs(mtcars)

fit1 <- lm(mpg ~ ., data = mtcars)
summary(fit1)$coeff
vif(fit1)
par(mfrow = c(2,2))
plot(fit1)


fit2 <- lm(mpg ~ am + hp + qsec, data = mtcars)
fit3 <- update(fit2, mpg ~ am + hp + qsec + cyl)
fit4 <- update(fit3, mpg ~ am + hp + qsec + cyl + wt)
anova(fit2,fit3,fit4)

summary(fit4)$coeff
fit5 <- lm(mpg ~ am + hp + qsec + wt, data = mtcars)
summary(fit5)$coeff
fit6 <- lm(mpg ~ am + qsec + wt, data = mtcars)
fit6 <- lm(mpg ~ am + qsec + wt, data = data)
summary(fit6)
par(mfrow = c(2,2))
plot(fit6)

describeBy(mtcars)

corrplot(as.matrix(mtcars[,-c(2,8,9)]), type="upper")

data <- mtcars[,-c(2,8,9)]
cor(data)
