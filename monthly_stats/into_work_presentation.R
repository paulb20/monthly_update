library(reshape2)
library(tidyverse)
library(readxl)
library(officer)
library(forecastHybrid)
library(forecast)
library(magrittr)
library(zoo)
library(chron)
library(ggthemes)
library(scales)
library(seasonal)
source("lwi_pal.R")
library(RCurl)
library(extrafont)
loadfonts(device="win")


currentdate <- Sys.Date()
#load("F:/R&C/Data/Recession_watch/monthly_stats/.RData")
download_address <- "./lms_14_06_2017"
lfsdate <- "Jan-Mar 2017"
lfs_expanded <- "January to March 2017"
claimantdate <- "2017 Apr"
jsaloneparentdate <- "Dec"
vacsdate <- "Feb-Apr 2017"
bensdate <- "2016-Aug"
dates_for_thresholds <- c("Apr 2016", "Jul 2016", "Oct 2016","Jan 2017", "Apr 2017")
dateforpngs <- paste0(months(currentdate), years(currentdate))
data_quarter <- "may2017" # changes quarterly (last one nov2016)


template_address <- "./"
excel_files <- list.files(download_address)
needed_files <- c("a02sa", "a06sa", "a07", "ben02", "ben03", "cla02", "emp01sa", "hour01sa", "inac01sa", "unem01sa", "vacs01", "jsalp", "ben01", "cla01")

A02 <- read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[1]),excel_files, value=TRUE)), skip=7) %>% filter(!is.na(MGSL))
zoo_A02 <- zooreg(A02[,-1], start=c(1971,2), frequency = 12)
Chart1_data <- zoo_A02[,16:18]
names(Chart1_data) <- c("Employment rate", "Unemployment rate", "Inactivity rate")
Chart1_data_short <- tail(Chart1_data, 25)
Chart1_data <- fortify.zoo(Chart1_data, melt=TRUE)
Chart1_data_short<- fortify.zoo(Chart1_data_short, melt=TRUE)
ggplot(data=Chart1_data, aes(x = Index, y = Value, group=Series)) + 
  geom_line(size=2, colour = "#ee7e3b") + facet_wrap(~Series, scales="free", nrow=3, strip.position = "right") + 
  scale_x_yearmon(format = "%b %Y") + scale_y_continuous(labels=comma) + 
  theme_economist_white(base_size=12, base_family="Raleway", gray_bg = FALSE) + 
  xlab(NULL) + ylab(NULL) + 
  scale_colour_lwi() + theme(legend.title=element_blank(), plot.margin = unit(c(0.1,0.1,0.5,0.1), "cm"))
ggsave("output/img/IntoworkChart1.png", width=15, height=9, unit="in")

ggplot(data=Chart1_data_short, aes(x = Index, y = Value, group=Series)) + 
  geom_line(size=2, colour = "#ee7e3b") + facet_wrap(~Series, scales="free", nrow=3, strip.position = "right") + 
  scale_x_yearmon(format = "%b %Y") + scale_y_continuous(labels=comma) + 
  theme_economist_white(base_size=12, base_family="Raleway", gray_bg = FALSE) + 
  xlab(NULL) + ylab(NULL) + 
  scale_colour_lwi() + theme(legend.title=element_blank(), plot.margin = unit(c(0.1,0.1,0.5,0.1), "cm"))
ggsave("output/img/IntoworkChart2.png", width=15, height=9, unit="in")

### Claimant work

CLA01 <- read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[14]),excel_files, value=TRUE)), 
                    skip=4, 
                    col_types = c("text", rep("numeric",5), rep("skip", 12)))
CLA01 <- filter(CLA01, !is.na(BCJD))
CLA01 <- CLA01[1:(nrow(CLA01)-4),]
zoo_CLA01 <- zooreg(CLA01[,-1], start=c(1971,1), frequency = 12)
BEN02 <- read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[4]),excel_files, value=TRUE)), 
                    skip=4,
                    col_names = FALSE,
                    col_types=c("skip", "text", "skip", rep("numeric", 6)))
BEN02 <- filter(BEN02, !is.na(X__2))
BEN02 <- BEN02[1:(nrow(BEN02)-4),]
zoo_BEN02 <- zooreg(BEN02[,-1], start=c(1971,1), frequency = 12)
claimants <- merge.zoo(zoo_BEN02$X__6, zoo_CLA01[,c(1:2,4)])
names(claimants) <- c("Unadjusted.JSA", "Adjusted.JSA", "Unadjusted.UC.Count", "ONS.Count.SA")
claimants$Unadjusted.UC.Count <- na.fill(claimants$Unadjusted.UC.Count,0 )
claimants$Unadjusted.Count <- claimants$Unadjusted.JSA + claimants$Unadjusted.UC.Count
claimants$LW.Count.SA <- zooreg(final(seas(as.ts(claimants$Unadjusted.Count))),frequency=12, start=c(1971,1))
ggplot(data=fortify(tail(claimants[,4:6],25), melt=TRUE), aes(x = Index, y = Value, colour=Series, )) + 
  geom_line(size=2) + 
  scale_x_yearmon(format = "%b %Y") + 
  scale_y_continuous(labels=comma) + 
  theme_economist_white(base_size=12, base_family="Raleway", gray_bg = FALSE) + 
  xlab(NULL) + ylab(NULL) + 
  scale_colour_lwi() + 
  theme(legend.title=element_blank(), plot.margin = unit(c(0.1,0.1,0.5,0.1), "cm"))
ggsave(paste0("output/img/Intoworkclaimants.png"), width=15, height=9, unit="in")

ggplot(data=fortify(tail(claimants[,4:6],50), melt=TRUE), aes(x = Index, y = Value, colour=Series, )) + 
  geom_line(size=2) + 
  scale_x_yearmon(format = "%b %Y") + 
  scale_y_continuous(labels=comma) + 
  theme_economist_white(base_size=12, base_family="Raleway", gray_bg = FALSE) + 
  xlab(NULL) + ylab(NULL) + 
  scale_colour_lwi() + 
  theme(legend.title=element_blank(), plot.margin = unit(c(0.1,0.1,0.5,0.1), "cm"))
ggsave(paste0("output/img/Intoworkclaimants_long.png"), width=15, height=9, unit="in")

#Forecasting

LW.Count.hybridModel <- hybridModel(claimants$LW.Count.SA)

LW.Count.forecast <- forecast(LW.Count.hybridModel, 60, fan=TRUE)


## Labour market flows
X02 <- read_excel(paste0(download_address, "/X02",data_quarter,".xls"), sheet=2, skip=6)
X02 %>% mutate(UE_HR = `Unemployment to Employment`/(`Still in unemployment` + `Unemployment to Employment` + `Unemployment to Inactivity`),
               NE_HR = `Inactivity to Employment` / (`Still in Inactivity` + `Inactivity to Employment` + `Inactivity to Unemployment`),
               J2J_HR = Levels / (`Still in employment` + `Employment to Unemployment` + `Employment to Inactivity`)) -> X02

zooX02 <- zooreg(X02[,28:30], frequency=4, start=c(2001,4))
seaszooX02 <- merge.zoo(
  zooreg(final(seas(as.ts(zooX02$J2J_HR))), frequency=4, start=c(2001,4)),
  zooreg(final(seas(as.ts(zooX02$UE_HR))), frequency=4, start=c(2001,4)),
  zooreg(final(seas(as.ts(zooX02$NE_HR))), frequency=4, start=c(2001,4))
)
colnames(seaszooX02) <- c("J2J_HR", "UE_HR", "NE_HR")
indexedX02 <- merge.zoo(
  zooreg(coredata(seaszooX02[,1])/coredata(seaszooX02[26,1]), frequency=4, start=c(2001,4)), 
  zooreg(coredata(seaszooX02[,2])/coredata(seaszooX02[26,2]), frequency=4, start=c(2001,4)),
  zooreg(coredata(seaszooX02[,3])/coredata(seaszooX02[26,3]), frequency=4, start=c(2001,4))
)
colnames(indexedX02) <- c("J2J_HR", "UE_HR", "NE_HR")
indexedX02 <- indexedX02*100
indexedX02_rollmean <- rollmean(indexedX02,4)
names(indexedX02_rollmean) <- c("Job to Job flow rate", "Unemployment to employment rate", "Inactivity to employment rate")
names(seaszooX02) <- c("Job to Job flow rate", "Unemployment to employment rate", "Inactivity to employment rate")

ggplot(data=fortify(rollmean(seaszooX02,4), melt=TRUE), aes(x = Index, y = Value, group=Series)) + 
  geom_line(size=2, colour = "#ee7e3b") + facet_wrap(~Series, scales="free", nrow=3) + 
  scale_x_yearmon(format = "%b %Y") + scale_y_continuous(labels=percent) + 
  theme_economist_white(base_size=12, base_family="Raleway", gray_bg = FALSE) + 
  xlab(NULL) + ylab(NULL) + 
  scale_colour_lwi() + theme(legend.title=element_blank())
ggsave("output/img/IntoworkChart6.png", width=15, height=9, unit="in")

ggplot(data=fortify(tail(rollmean(seaszooX02,4),9), melt=TRUE), aes(x = Index, y = Value, group=Series)) + 
  geom_line(size=2, colour = "#ee7e3b") + facet_wrap(~Series, scales="free", nrow=3) + 
  scale_x_yearmon(format = "%b %Y") + scale_y_continuous(labels=percent) + 
  theme_economist_white(base_size=12, base_family="Raleway", gray_bg = FALSE) + 
  xlab(NULL) + ylab(NULL) + 
  scale_colour_lwi() + theme(legend.title=element_blank())
ggsave("output/img/IntoworkChart6b.png", width=15, height=9, unit="in")

LW.Count.hybridModel <- hybridModel(claimants$LW.Count.SA)
LW.Count.forecast <- forecast(LW.Count.hybridModel, 60, fan=TRUE)

my_pres <- read_pptx("intoworktemplate.pptx")
my_pres <- my_pres %>% 
  add_slide(layout = "Title Slide", master = "Office Theme") 
my_pres <- my_pres %>% ph_with_text(type="ctrTitle", str= paste0("State of the Labour Market\n", years(currentdate)))
