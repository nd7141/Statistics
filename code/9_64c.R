data <- read.table("bodytemp.txt", header = T, sep=',')
summary(data)
m_temp <- data[data$gender == 1, 1]
m_temp
