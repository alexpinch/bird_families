# Alex Pinch
# Generates birdfamilies.ca landing page

library(tidyverse)
setwd("/Users/alexpinch/GitHub/public/birdfamilies")
data <- read_csv("birds.csv")

# reformat csv data to hierarchical structure
tree <- data %>%
  group_by(FAMILY, GENUS) %>%
  reframe(SPECIES = paste(COMMON_NAME, "(", LATIN_NAME, ")", sep = ""), .groups = "drop") # reframe instead of summarize

# convert to nested lists, chatGPT gave
build_html_list <- function(df) {
  html <- "<ul>"
  families <- unique(df$FAMILY)
  
  for (family in families) {
    html <- paste0(html, "<li>", family)
    
    genus_data <- df %>% filter(FAMILY == family)
    genera <- unique(genus_data$GENUS)
    
    html <- paste0(html, "<ul>")
    for (genus in genera) {
      html <- paste0(html, "<li>", genus)
      
      species_data <- genus_data %>% filter(GENUS == genus)
      species <- species_data$SPECIES
      
      html <- paste0(html, "<ul>")
      for (specie in species) {
        html <- paste0(html, "<li>", specie, "</li>")
      }
      html <- paste0(html, "</ul>")
      html <- paste0(html, "</li>")
    }
    html <- paste0(html, "</ul>")
    html <- paste0(html, "</li>")
  }
  html <- paste0(html, "</ul>")
  
  return(html)
}

html_list <- build_html_list(tree)

# paste 
html_content <- paste0("
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>birdfamilies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        ul {
            list-style-type: none;
        }
        ul ul {
            margin-left: 20px;
            padding-left: 20px;
            border-left: 1px solid #ccc;
        }
        li {
            margin: 5px 0;
            padding: 5px 0;
            position: relative;
        }
        li::before {
            content: '';
            position: absolute;
            top: 10px;
            left: -20px;
            width: 10px;
            height: 1px;
            background: #ccc;
        }
    </style>
</head>
<body>
    <h1>birdfamilies</h1>
    ", html_list, "
</body>
</html>
")

writeLines(html_content, "index.html")
cat("index HTML file generated\n")
