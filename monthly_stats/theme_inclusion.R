require(ggthemes)

theme_inclusion <-function (base_size = 8, base_family = "sans", horizontal = TRUE, 
          dkpanel = FALSE, stata = FALSE) 
{
  if (stata) {
    bgcolors <- ggthemes_data$economist$stata$bg
  }
  else {
    bgcolors <- ggthemes_data$economist$bg
  }
  ret <- theme(line = element_line(colour = "black", size = 0.5, 
                                   linetype = 1, lineend = "butt"), rect = element_rect(fill = bgcolors["ebg"], 
                                                                                        colour = NA, size = 0.5, linetype = 1), text = element_text(family = base_family, 
                                                                                                                                                    face = "plain", colour = "black", size = base_size, hjust = 0.5, 
                                                                                                                                                    vjust = 0.5, angle = 0, lineheight = 1), axis.text = element_text(size = rel(1)), 
               axis.line = element_line(size = rel(0.8)), axis.line.y = element_blank(), 
               axis.text.x = element_text(vjust = 1), axis.text.y = element_text(hjust = 0), 
               axis.ticks = element_line(), axis.ticks.y = element_blank(), 
               axis.title = element_text(size = rel(1)), axis.title.x = element_text(), 
               axis.title.y = element_text(angle = 90), axis.ticks.length = unit(-base_size * 
                                                                                   0.5, "points"), axis.ticks.margin = unit(base_size * 
                                                                                                                              1.25, "points"), legend.background = element_rect(linetype = 0), 
               legend.margin = unit(base_size * 1.5, "points"), legend.key = element_rect(linetype = 0), 
               legend.key.size = unit(1.2, "lines"), legend.key.height = NULL, 
               legend.key.width = NULL, legend.text = element_text(size = rel(1.25)), 
               legend.text.align = NULL, legend.title = element_text(size = rel(1), 
                                                                     hjust = 0), legend.title.align = NULL, legend.position = "top", 
               legend.direction = NULL, legend.justification = "center", 
               panel.background = element_rect(linetype = 0), panel.border = element_blank(), 
               panel.grid.major = element_line(colour = "white", size = rel(1.75)), 
               panel.grid.minor = element_blank(), panel.margin = unit(0.25, 
                                                                       "lines"), strip.background = element_rect(fill = bgcolors["ebg"], 
                                                                                                                 colour = NA, linetype = 0), strip.text = element_text(size = rel(1.25)), 
               strip.text.x = element_text(), strip.text.y = element_text(angle = -90), 
               plot.background = element_rect(fill = bgcolors["ebg"], 
                                              colour = NA), plot.title = element_text(size = rel(1.5), 
                                                                                      hjust = 0, face = "bold"), plot.margin = unit(c(6, 
                                                                                                                                      5, 6, 5) * 2, "points"), complete = TRUE)
  if (horizontal) {
    ret <- ret + theme(panel.grid.major.x = element_blank())
  }
  else {
    ret <- ret + theme(panel.grid.major.y = element_blank())
  }
  if (dkpanel == TRUE) {
    ret <- ret + theme(panel.background = element_rect(fill = bgcolors["edkbg"]), 
                       strip.background = element_rect(fill = bgcolors["edkbg"]))
  }
  ret
}
