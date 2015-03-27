data <- read.table("poison_treatment.txt", header=T)
attach(basketball)

# a
tapply(time, poison,mean)
#       I      II     III 
# 6.17500 5.43125 2.76250 
tapply(time, treatment, mean)
#        A        B        C        D 
# 3.141667 6.766667 3.925000 5.325000 

# Comparing two sets of means, we can say that
# the longest survival time for poison type I and
# treatment type B. Hoever, it may be due to chance.
# We check it with ANOVA. 

# model that includes interaction
int <- aov(time ~ treatment*poison)
summary(int)
#                 Df Sum Sq Mean Sq F value   Pr(>F)    
# treatment         3  91.90   30.63  14.015 3.28e-06 ***
#   poison            2 103.04   51.52  23.570 2.86e-07 ***
#   treatment:poison  6  24.75    4.12   1.887     0.11    
# Residuals        36  78.69    2.19                     
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# simple additive model
noint <- aov(time ~ poison + treatment)
summary(noint)
# Df Sum Sq Mean Sq F value   Pr(>F)    
# poison       2  103.0   51.52   20.92 4.96e-07 ***
#   treatment    3   91.9   30.63   12.44 5.89e-06 ***
#   Residuals   42  103.4    2.46 

# Since p-value is small, it suggests that difference in means is not due to chance

# b
tapply(1/time, poison,mean)
# I        II       III 
# 0.1800688 0.2270554 0.3797112 
tapply(1/time, treatment, mean)
# A         B         C         D 
# 0.3519345 0.1861943 0.2947210 0.2162641

int <- aov(1/time ~ poison*treatment)
summary(int)
# Df Sum Sq Mean Sq F value   Pr(>F)    
# poison            2 0.3486 0.17432  72.842 2.22e-13 ***
#   treatment         3 0.2040 0.06799  28.410 1.34e-09 ***
#   poison:treatment  6 0.0157 0.00261   1.091    0.386    
# Residuals        36 0.0862 0.00239                     
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

noint <- aov(1/time ~ poison + treatment)
summary(noint)
# Df Sum Sq Mean Sq F value   Pr(>F)    
# poison       2 0.3486 0.17432   71.91 2.74e-14 ***
#   treatment    3 0.2040 0.06799   28.05 4.06e-10 ***
#   Residuals   42 0.1018 0.00242                     
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Result of inverse time can be interpreted as rate of death. Results are 
# consistent and show that difference in treatment for different 
# poisons is not due to chance