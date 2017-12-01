#library(tidyverse)
library(readxl)
library(zoo)
library(writexl)
data_month <- "sep2017" # as per ONS web addresses
data_quarter <- "aug2017" # changes quarterly (last one aug2017)
download_address <- "./lms_13-09-2017/"
excel_files <- list.files(download_address)
needed_files <- c("a02sa", "a06sa", "a07", "ben02", "ben03", "cla02", "emp01sa", "hour01sa", "inac01sa", "unem01sa", "vacs01", "jsalp", "ben01", "cla01")

#Hours
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/earningsandworkinghours/datasets/actualweeklyhoursworkedseasonallyadjustedhour01sa/current/hour01sa", data_month,".xls"), paste0(download_address, "hour01sa",data_month,".xls"), mode="wb", method="libcurl")
#Claimant count by age
download.file(paste0("http://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/outofworkbenefits/datasets/cla02claimantcountbyagegroup/current/cla02", data_month,".xls"), paste0(download_address, "cla02",data_month,".xls"), mode="wb", method="libcurl")
#a02sa
download.file(paste0("http://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/employmentunemploymentandeconomicinactivityforpeopleaged16andoverandagedfrom16to64seasonallyadjusteda02sa/current/a02sa", data_month,".xls"), paste0(download_address, "a02sa",data_month,".xls"), mode="wb", method="libcurl")
#a06sa
download.file(paste0("http://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/educationalstatusandlabourmarketstatusforpeopleagedfrom16to24seasonallyadjusteda06sa/current/a06sa", data_month,".xls"), paste0(download_address, "a06sa",data_month,".xls"), mode="wb", method="libcurl")
#cla01
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/outofworkbenefits/datasets/claimantcountcla01/current/cla01", data_month,".xls"), paste0(download_address, "cla01",data_month,".xls"), mode="wb", method="libcurl")

#inac01
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/economicinactivity/datasets/economicinactivitybyreasonseasonallyadjustedinac01sa/current/inac01sa", data_month,".xls"), paste0(download_address, "inac01sa",data_month,".xls"), mode="wb", method="libcurl")

#emp01
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/fulltimeparttimeandtemporaryworkersseasonallyadjustedemp01sa/current/emp01sa", data_month,".xls"), paste0(download_address, "emp01sa",data_month,".xls"), mode="wb", method="libcurl")

#ben03
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/outofworkbenefits/datasets/jobseekersallowancebyageanddurationben03/current/ben03", data_month,".xls"), paste0(download_address, "ben03",data_month,".xls"), mode="wb", method="libcurl")

#ben02
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/outofworkbenefits/datasets/jobseekersallowanceclaimantsben02/current/ben02", data_month,".xls"), paste0(download_address, "ben02",data_month,".xls"), mode="wb", method="libcurl")

#X02
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/labourforcesurveyflowsestimatesx02/current/x02sep2017.xls"), paste0(download_address, "X02",data_quarter,".xls"), mode="wb", method="libcurl")

#ben01
#download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/outofworkbenefits/datasets/mainoutofworkbenefitsben01/current/ben01", data_quarter,".xls"), paste0(download_address, "ben01",data_quarter,".xls"), mode="wb", method="libcurl")

#a07
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/regionallabourmarketsummarya07/current/a07", data_month,".xls"), paste0(download_address, "a07",data_month,".xls"), mode="wb", method="libcurl")

#unem01
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/unemployment/datasets/unemploymentbyageanddurationseasonallyadjustedunem01sa/current/unem01sa", data_month,".xls"), paste0(download_address, "unem01sa",data_month,".xls"), mode="wb", method="libcurl")

#vacs01
download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peoplenotinwork/unemployment/datasets/vacanciesandunemploymentvacs01/current/vacs01", data_month,".xls"), paste0(download_address, "vacs01",data_month,".xls"), mode="wb", method="libcurl")

#regional_nomis
download.file("http://www.nomisweb.co.uk/articles/news/files/LFS%20headline%20indicators.xls", paste0(download_address, "lfs_headline_indicators",data_month,".xls"), mode="wb", method="libcurl")

# A05 - Age

download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/employmentunemploymentandeconomicinactivitybyagegroupseasonallyadjusteda05sa/current/a05sa", data_month,".xls"), paste0(download_address, "a08",data_month,".xls"), mode="wb", method="libcurl")

#A08 - Disability

download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/labourmarketstatusofdisabledpeoplea08/current/a08", data_quarter,".xls"), paste0(download_address, "a08",data_quarter,".xls"), mode="wb", method="libcurl")

#A09 - Ethnicity

download.file(paste0("https://www.ons.gov.uk/file?uri=/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/datasets/labourmarketstatusbyethnicgroupa09/current/a09", data_quarter,".xls"), paste0(download_address, "a09",data_quarter,".xls"), mode="wb", method="libcurl")

# LFS load_data
#A02
overall <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[1]),excel_files, value=TRUE)), sheet=1, skip=7),-20)[-1,]
maleallage <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[1]),excel_files, value=TRUE)), sheet=2, skip=7),-20)[-1,]
femaleallage <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[1]),excel_files, value=TRUE)), sheet=3, skip=7),-20)[-1,]
#A06
youth <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[2]),excel_files, value=TRUE)), sheet=1, skip=7),-8)[-1,]
#Emp01
involunt_emp <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[7]),excel_files, value=TRUE)), sheet=1, skip=7),-8)[-1,]
#Inac01
inactivity <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[9]),excel_files, value=TRUE)), sheet=1, skip=7, col_types = c("text", rep("numeric",48))),-3)[-1,]
#Unem01
unemall <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[10]),excel_files, value=TRUE)), sheet=1, skip=7),-6)[-1,]
#Hour01
hours <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[8]),excel_files, value=TRUE)), sheet=1, skip=7),-6)[-1,]
male_hours <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[8]),excel_files, value=TRUE)), sheet=2, skip=7),-6)[-1,]
female_hours <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[8]),excel_files, value=TRUE)), sheet=3, skip=7),-6)[-1,]
#a07
regionstocks <- read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[3]),excel_files, value=TRUE)), range="A14:M25", col_names = FALSE, trim_ws = TRUE)
regionstocks <- regionstocks[,c(2:4,6:7,9:10, 12:13)]

regionquarter <- read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[3]),excel_files, value=TRUE)), range="A37:M48", col_names = FALSE, trim_ws = TRUE)
regionquarter <- regionquarter[,c(2:4,6:7,9:10, 12:13)]

# Benefit claimants (ONS)

#Ben01
bens_claimants <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[13]),excel_files, value=TRUE)), sheet=1, skip=5, col_names = FALSE, col_types = c("skip", "text", "skip", rep("numeric", 5))),-16)
#Ben02
claimants <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[4]),excel_files, value=TRUE)), sheet=1, skip=5, col_names = FALSE, col_types = c("skip", "text", "skip", rep("numeric", 6))),-911)
male_claimants <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[4]),excel_files, value=TRUE)), sheet=2, skip=5, col_names = FALSE, col_types = c("skip", "text", "skip", rep("numeric", 6))),-919)
female_claimants <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[4]),excel_files, value=TRUE)), sheet=3, skip=5, col_names = FALSE, col_types = c("skip", "text", "skip", rep("numeric", 6))),-919)

#Ben03
duration_claimants <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[5]),excel_files, value=TRUE)), sheet=1, skip=6, col_names = FALSE, col_types = c("skip", "text", "skip", rep("numeric", 37))),-11)
#Cla01
claimants2 <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[14]),excel_files, value=TRUE)), sheet=1, skip=4, col_types = c("text", rep("numeric", 12))),-13)
#Cla02
ageclaimants2 <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[6]),excel_files, value=TRUE)), sheet=1, skip=4, col_types = c("text", rep("numeric", 5))),-13)


# Vacancies

#Vacs01
vacancies <- head(read_excel(paste0(download_address, "/",grep(paste0("^",needed_files[11]),excel_files, value=TRUE)), sheet=1, skip=4, col_types = c("text", "skip",rep("numeric", 3), "skip", "skip")),-6)


# threshold flows (JSA)

file_loc <- paste0(download_address, "seasonal_pars_data.xls")

# Get file from NOMIS
download.file("http://www.nomisweb.co.uk/livelinks/1956.xls?namedranges=yes", file_loc, mode="wb")
# Link to file
# Import data from excel file
T1_stocks_durations <- head(read_excel(file_loc, skip=7, col_types = c("skip", rep("numeric",6))),-4)

# closes link to Excel file
# Transform to time series or zoo objects
test_ts <- as.zoo(ts(T1_stocks_durations,start=c(1985,6),frequency = 12))

#create a duplicate table, lagged by -3 months
#Error here - getting the right lag() is hard

testlag <- stats::lag(test_ts,-3)
# Create table of original divided by the lagged table, offset by one column
par1 <- test_ts[,2:6]/testlag[,1:5]
library(seasonal)
# similar for the 12-month rate
testlag12 <- stats::lag(test_ts[,1], -12)
par12 <- test_ts[,5]/testlag12

# Use seasadj() function ( Prof RJ Hyndman, Monash University) to produce adjusted series
seastest1 <- as.zoo(final(seas(as.ts(par1[,1]))))
seastest2 <- as.zoo(final(seas(as.ts(par1[,2]))))
seastest3 <- as.zoo(final(seas(as.ts(par1[,3]))))
seastest4 <- as.zoo(final(seas(as.ts(par1[,4]))))
seastest5 <- as.zoo(final(seas(as.ts(par1[,5]))))

seastest_12 <- as.zoo(final(seas(as.ts(par12))))

# Put them all together
season_pars <-merge.zoo(seastest1, seastest2, seastest3, seastest4, seastest5)
colnames(season_pars) <- c("Proportion remaining beyond 3 months", "Proportion 3-6 months remaining 6-9 months", "Proportion 6-9 months remaining 9-12 months", "Proportion 9-12 months remaining 12-15 months", "Proportion 12-15 months remaining 15-18 months")

write_xlsx(data.frame(date=index(season_pars), coredata(season_pars)), paste0(download_address, "/season_pars_out2.xlsx"), col_names = TRUE)


