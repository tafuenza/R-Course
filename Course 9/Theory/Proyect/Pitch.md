Shiny Application and Reproducible Pitch
========================================================
author: Tomás Fuenzalida
date: 05/06/220
autosize: FALSE

Shiny App, Earthquakes on Earth

The application
========================================================

The data set of the kaggle website on earthquakes in the world is used to create an interactive website that allows to filter earthquakes by different parameters to see them on a real map


Data Collect
========================================================

Para la aplicacion se utilizo la informacion de sismos del sitio web:
[Dataset](https://www.kaggle.com/usgs/earthquake-database)


```
        Date Latitude Longitude       Type Depth Magnitude
1 1965-01-02       19       145 Earthquake 131.6       6.0
2 1965-01-04        1       127 Earthquake  80.0       5.8
3 1965-01-05      -20      -173 Earthquake  20.0       6.2
4 1965-01-08      -59       -23 Earthquake  15.0       5.8
5 1965-01-09       11       126 Earthquake  15.0       5.8
6 1965-01-10      -13       166 Earthquake  35.0       6.7
```


Linear Regresion
========================================================


```

Call:
lm(formula = Magnitude ~ Depth, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-0.4338 -0.2806 -0.1772  0.1225  3.2208 

Coefficients:
             Estimate Std. Error  t value Pr(>|t|)    
(Intercept) 5.877e+00  3.192e-03 1841.211  < 2e-16 ***
Depth       8.138e-05  2.255e-05    3.609 0.000308 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.423 on 23407 degrees of freedom
Multiple R-squared:  0.0005562,	Adjusted R-squared:  0.0005135 
F-statistic: 13.03 on 1 and 23407 DF,  p-value: 0.0003078
```

How to use the app
========================================================

The documentation tab has the instructions to use the app properly.
The map, graph and data tabs provide information on the events that meet the criteria selected in the bar on the right side  
[Shiny App](https://tomas-fuenzalida.shinyapps.io/Proyect/)  
[Github Code](https://github.com/tafuenza/R-Course/tree/master/Course%209/Theory/Proyect)
