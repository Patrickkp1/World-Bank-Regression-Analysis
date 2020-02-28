getwd()

df <- data.table::fread("~/API_BN.KLT.DINV.CD_DS2_en_csv_v2_712994.csv")
View(df)
df2 <- data.table::fread("~/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_713080.csv")
df3 <- data.table::fread("~/API_VC.IHR.PSRC.P5_DS2_en_csv_v2_718934.csv")
library(WDI)
library(dplyr)

df <- data.frame(WDI(country = c("USA", "BRA", "MEX", "ARG", "GTM", "SLV", 
                                 "BOL", "ESP", "PER", "CHL", "COL", "URY"),
                     indicator = "BN.KLT.DINV.CD",
                     start = 1960,
                     end = 2017,
                     extra = FALSE))

df2 <- data.frame(WDI(country = c("USA", "BRA", "MEX", "ARG", "GTM", "SLV", 
                                   "BOL", "ESP", "PER", "CHL", "COL", "URY"),
                     indicator = "NY.GDP.PCAP.CD",
                     start = 1960,
                     end = 2017, 
                     extra = FALSE))

df3 <- data.frame(WDI(country = c("USA", "BRA", "MEX", "ARG", "GTM", "SLV", 
                                   "BOL", "ESP", "PER", "CHL", "COL", "URY"),
                      indicator = "VC.IHR.PSRC.P5",
                      start = 1960, 
                      end = 2017, 
                      extra = FALSE))

View(df)
View(df2)
View(df3)
names(df)[1:4]
FDI <- select(df, -(iso2c))
GDP <- select(df2, -(iso2c))
CRIME <- select(df3, -(iso2c))

names(GDP) <- c("Country", "GDP per capita", "Year")
names(CRIME) <- c("Country", "Homicide Rate", "Year")
names(FDI) <- c("Country", "FDI", "Year")

View(GDP)
View(FDI)
View(CRIME)

any(is.na(FDI))
any(is.na(CRIME))
any(is.na(GDP))

library(finalfit)
library(rstan)
library(boot)

lm(FDI$FDI ~ GDP$`GDP per capita`)
lm(FDI$FDI ~ CRIME$`Homicide Rate`)


my.df <- merge(FDI, GDP, by = c("Country", "Year"))
model <- lm(FDI ~ `GDP per capita`, data=my.df)
plot(FDI$FDI, GDP$`GDP per capita`, main = "Regression of GDP on FDI", 
     ylab = "GDP", xlab = "FDI")

abline(model, col = "red")

my.df <- merge(FDI, GDP, by = c("Country", "Year"))
model <- merge(my.df, CRIME, by = c("Country", "Year"))

View(model)

GDP2 <- (GDP$`GDP per capita`)^2
Multi.linear <- lm(FDI ~ `GDP per capita` + GDP2 + `Homicide Rate`, data = model)




