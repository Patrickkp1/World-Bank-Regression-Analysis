getwd()

df <- data.table::fread("~/API_BN.KLT.DINV.CD_DS2_en_csv_v2_712994.csv")
df2 <- data.table::fread("~/API_NY.GDP.PCAP.CD_DS2_en_csv_v2_713080.csv")
df3 <- data.table::fread("~/API_VC.IHR.PSRC.P5_DS2_en_csv_v2_718934.csv")

library(WDI)
library(dplyr)

df <- data.frame(WDI(country = c("MEX"),
                     indicator = "BN.KLT.DINV.CD",
                     start = 1990,
                     end = 2018,
                     extra = FALSE))
View(df2)
df2 <- data.frame(WDI(country = c("MEX"),
                     indicator = "NY.GDP.PCAP.CD",
                     start = 1990,
                     end = 2018, 
                     extra = FALSE))
View(df3)
df3 <- data.frame(WDI(country = c("MEX"),
                      indicator = "VC.IHR.PSRC.P5",
                      start = 1990, 
                      end = 2018, 
                      extra = FALSE))

names(df)[1:4]
FDI <- select(df, -(iso2c))
GDP <- select(df2, -(iso2c))
CRIME <- select(df3, -(iso2c))

lm(FDI ~ GDP)
ridge







