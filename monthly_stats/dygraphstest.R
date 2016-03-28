library(dygraphs)
library(xts)
library(htmlwidgets)

FUNC_JSFormatNumber <- "function(x) {return x.toString().replace(/(\\d)(?=(\\d{3})+(?!\\d))/g, '$1,')}"
Unemployed2 <- round(Unemployed/1000,0)*1000
names(Unemployed2) <- "ILO Unemployed"
test.dygraph <- dygraph(as.xts(Unemployed2, 
                        as.yearmon(index(Unemployed2)))) %>% 
  dySeries("V1", label="ILO Unemployed", strokeWidth=3) %>%
  dyRangeSelector(dateWindow = c("2013-11-01", "2015-11-01")) %>% 
  dyAxis("y", axisLabelFormatter=JS(FUNC_JSFormatNumber), valueFormatter=JS(FUNC_JSFormatNumber))
saveWidget(test.dygraph, "Unemployment_dygraph.html", selfcontained = TRUE)

season_pars2 <- round(season_pars, 2) *100
test2.dygraph <- dygraph(as.xts(season_pars2, as.yearmon(index(season_pars2)))) %>% 
  dyRangeSelector(dateWindow = c("2014-01-01", "2016-01-01")) %>% 
  dySeries("Proportion remaining beyond 3 months", strokeWidth=3) %>%
  dySeries("Proportion 3-6 months remaining 6-9 months", strokeWidth=3) %>%
  dySeries("Proportion 6-9 months remaining 9-12 months", strokeWidth=3) %>%
  dySeries("Proportion 9-12 months remaining 12-15 months", strokeWidth=3) %>%
  dySeries("Proportion 12-15 months remaining 15-18 months", strokeWidth=3) %>%
  dyAxis("y", axisLabelFormatter = JS('function(d) {var x = d + "%";
    return x;
  }'), valueFormatter = JS('function(d) {var x = d + "%";
    return x;
  }')) %>% dyOptions(digitsAfterDecimal = 1) %>%
  dyHighlight(highlightCircleSize = 5, 
              highlightSeriesBackgroundAlpha = 0.2)
  
saveWidget(test2.dygraph, "season_pars_dygraph.html", selfcontained = TRUE)
