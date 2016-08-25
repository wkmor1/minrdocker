FROM debian:stable
MAINTAINER William K Morris <wkmor1@gmail.com>

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
         r-base-dev \
         jags \
         pandoc \
    && echo 'options(repos = list(CRAN = "http://cloud.r-project.org/"))' > /etc/R/Rprofile.site \     
    && R -e 'install.packages(c("jagsUI", "lubridate", "purrr", "readxl", "rmarkdown", "tidyr"))' \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf var/lib/apt/lists/*  /tmp/downloaded_packages/ /tmp/*.rds
