
library(rvest)
library(dplyr)
library(data.table)

results_per_page <- 20

base_url <- 'https://beta.companieshouse.gov.uk/search/companies?q='
search <- 'a'


get_this <- paste(base_url, search, sep='')
total_results <- read_html(get_this) %>% 
  html_nodes(xpath='//div//p') %>% 
  html_text() %>% 
  data.frame %>% 
  filter(grepl('matches\n', .)) %>% 
  .[['.']] %>% 
  as.character %>% 
  gsub('[^0-9]', '', .) %>% 
  as.numeric

pages_to_get <- total_results/results_per_page

#res <- list()

max_iterations = 100000
pb <- txtProgressBar(min = 0, max = min(pages_to_get, max_iterations), style = 3)

for(iter in max(1, length(res)):min(pages_to_get, max_iterations)){
  get_this <- paste(base_url, search, '&page=', iter, sep='')
  html_page <- read_html(get_this)
  company_names <- html_page %>% 
  html_nodes(xpath='//div//h3') %>% 
  html_text() %>% 
  gsub('\n', '', .) %>% 
  gsub('\t', '', .)
  
  company_ids <- html_page %>% 
  html_nodes(xpath='//div//h3//a') %>% 
  as.character %>% 
  substr(19, 26)
  
  results_from_companies_house[[i]] <- data.frame(company_ids, company_names)
  setTxtProgressBar(pb, i)
}
close(pb)




x %>% 
  html_node('article') %>% 
  html_text()


x %>% 
  html_nodes(xpath='//div//h3') %>% 
  html_text()



library(data.table)
