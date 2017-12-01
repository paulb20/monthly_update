# From an idea by
#"@lenkiefer",
#Deputy Chief Economist at Freddie Mac, United States",

library(jsonlite)
  library(tidyverse)
  library(xts)
  library(geofacetS)
  mygrid <- data.frame(
    row = c(1, 2, 2, 3, 3, 4, 5, 5, 4, 6, 5, 6),
    col = c(3, 1, 4, 3, 4, 4, 2, 4, 3, 2, 3, 4),
    name = c("Scotland", "Northern Ireland", "North East", "North West", "Yorkshire & the Humber", "East Midlands", "Wales", "Eastern", "West Midlands", "South West", "London", "South East"),
    code=c("Scotland", "Northern Ireland", "North East", "North West", "Yorkshire & the Humber", "East Midlands", "Wales", "Eastern", "West Midlands", "South West", "London", "South East"),
    stringsAsFactors = FALSE
  )
  #geofacet::grid_preview(mygrid)
  
  NE <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3p/data")
  NE <- zooreg(as.numeric(NE$months$value), start=c(1992,4), frequency = 12)
  NW <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3q/data")
  NW <- zooreg(as.numeric(NW$months$value), start=c(1992,4), frequency = 12)
  YH <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3r/data")
  YH <- zooreg(as.numeric(YH$months$value), start=c(1992,4), frequency = 12)
  EM <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3s/data")
  EM <- zooreg(as.numeric(EM$months$value), start=c(1992,4), frequency = 12)
  WM <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3t/data")
  WM <- zooreg(as.numeric(WM$months$value), start=c(1992,4), frequency = 12)
  EE <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3u/data")
  EE <- zooreg(as.numeric(EE$months$value), start=c(1992,4), frequency = 12)
  LN <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3v/data")
  LN <- zooreg(as.numeric(LN$months$value), start=c(1992,4), frequency = 12)
  SE <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3w/data")
  SE <- zooreg(as.numeric(SE$months$value), start=c(1992,4), frequency = 12)
  SW <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3x/data")
  SW <- zooreg(as.numeric(SW$months$value), start=c(1992,4), frequency = 12)
  WA <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf3z/data")
  WA <- zooreg(as.numeric(WA$months$value), start=c(1992,4), frequency = 12)
  SC <- fromJSON("http://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/timeseries/lf42/data")
  SC <- zooreg(as.numeric(SC$months$value), start=c(1992,4), frequency = 12)
  
  
  reg_emprates <- merge.zoo(NE, NW, YH, EM, WM, EE, LN, SE, SW, WA, SC)
  names(reg_emprates) <- c("North East", "North West", "Yorkshire & the Humber", "East Midlands", "West Midlands", "Eastern", "London", "South East", "South West", "Wales", "Scotland")
  
  reg_emprates_melted <- fortify(reg_emprates, melt=TRUE)
  reg_emprates_melted$Year <- year(reg_emprates_melted$Index)
  reg_emprates_melted$Month <- factor(months(reg_emprates_melted$Index))
  
  
  ggplot(data=reg_emprates_melted, 
         aes(x=Year,y=Month,
             fill=Value))+
    geom_tile()+
    scale_fill_viridis(option="D",name="Employment Rate (%) ")+
    scale_y_discrete(breaks=c(1,12),labels=c("January","December"))+
    scale_x_continuous(breaks=c(1992,2017))+
    facet_geo(~Series, grid=mygrid)+
    labs(x="",y="",title="Employment rate by region",
         caption=paste0("Learning & Work Institute"))+
    theme(plot.title=element_text(face="bold",size=18),
          legend.position="top",
          plot.subtitle=element_text(face="italic",size=14),
          plot.caption=element_text(face="italic",size=9),
          axis.text=element_text(size=6))
