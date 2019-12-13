FROM rocker/shiny
MAINTAINER Tamas Szilagyi (tszilagyi@outlook.com)

## install R package dependencies (and clean up)
 RUN apt-get update && apt-get install -y gnupg2 \
     libssl-dev \
     && apt-get clean \ 
     && rm -rf /var/lib/apt/lists/ \ 
     && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
## install packages from CRAN (and clean up)
RUN Rscript -e "install.packages(c('devtools','dplyr','tidyr','fuzzyjoin','stringr','ggthemes','quantmod','ggplot2','shinydashboard','shinythemes','devtools','webdriver'), repos='https://cran.rstudio.com/')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## install packages from github (and clean up)
##RUN Rscript -e "devtools::install_github('rstudio/shinytest','rstudio/webdriver')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## install phantomjs
RUN Rscript -e "webdriver::install_phantomjs()"

## assume shiny app is in build folder /app2
COPY ./app2 /srv/shiny-server/usa-trade/

## updated config file
COPY ./shiny-server.conf /etc/shiny-server/shiny-server.conf


