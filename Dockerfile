FROM debian:stable
MAINTAINER William K Morris <wkmor1@gmail.com>

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
         r-base-dev \
         jags \
    && echo 'options(repos = list(CRAN = "https://cran.rstudio.com/"))' > /etc/R/Rprofile.site \     
    && R -e 'install.packages(c("rJava", "readxl", "tidyr", "lubridate", "purrr", "jagsUI"))' \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf var/lib/apt/lists/*  /tmp/downloaded_packages/ /tmp/*.rds
