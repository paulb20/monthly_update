inclusion_pal <-function (fill = TRUE) 
{
  {
    #colors <- ggthemes_data$economist$fg
    if (fill) {
      function(n) {
        if (n == 1) {
          i <- "#1C1666"
        }
        else if (n == 2) {
          i <- c("#C80F3F", "#1C1666")
        }
        else if (n == 3) {
          i <- c("#7B60AA", "#1C1666", "#C80F3F")
        }
        else if (n == 4) {
          i <- c("#7B60AA", "#1C1666", "#C80F3F", 
                 "#83B431")
        }
        else if (n %in% 5:6) {
          i <- c("#7B60AA", "#1C1666", "#7B0A1D", 
                 "#C80F3F", "#77B7D4", "#189956")
        }
        else if (n == 7) {
          i <- c("#7B60AA", "#1C1666", "#C80F3F", 
                 "#7B0A1D", "#189956", "#77B7D4", 
                 "#83B431")
        }
        else if (n >= 8) {
          i <- c("#7B60AA", "#1C1666", "#C80F3F", 
                 "#7B0A1D", "#189956", "#77B7D4", 
                 "#FD9102", "#0086D4", "#83B431")
        }
#        unname(colors[i][seq_len(n)])
      }
    }
    else {
      function(n) {
        if (n <= 3) {
          i <- c("#1C1666", "#C80F3F", "#7B0A1D")
        }
        else if (n %in% 4:5) {
          i <- c("#1C1666", "#C80F3F", "#7B0A1D", 
                 "#7B60AA", "#83B431")
        }
        else if (n == 6) {
          i <- c("#77B7D4", "#189956", "#83B431", 
                 "#7B60AA", "#7B0A1D", "#1C1666")
        }
        else if (n > 6) {
          i <- c("#77B7D4", "#189956", "#83B431", 
                 "#7B60AA", "#7B0A1D", "#1C1666", "#FD9102", 
                 "#0086D4", "#EDC400")
        }
#        unname(colors[i][seq_len(n)])
      }
    }
  }
}

scale_colour_inclusion <- function (stata = FALSE, ...) 
{
  discrete_scale("colour", "inclusion", inclusion_pal(), 
                 ...)
}

scale_fill_inclusion <- function (stata = FALSE, ...) 
{
  discrete_scale("fill", "inclusion", inclusion_pal(), 
                 ...)
}