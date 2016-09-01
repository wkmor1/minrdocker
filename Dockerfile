FROM debian:stable
MAINTAINER William K Morris <wkmor1@gmail.com>

RUN    echo "deb http://cloud.r-project.org/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list \
    && apt-key adv --keyserver keys.gnupg.net --recv-keys 381BA480 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
         r-base-dev \
         jags \
         pandoc \
         texlive-latex-base \
    && tlmgr update --self \
    && tlmgr update --all \
    && tlmgr update install tufte-latex \
    && echo 'options(repos = list(CRAN = "http://cloud.r-project.org/"))' > /etc/R/Rprofile.site \ 
    && R -e 'install.packages(c("jagsUI", "lubridate", "purrr", "readxl", "tidyr", "tufte"))' \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf var/lib/apt/lists/*  /tmp/downloaded_packages/ /tmp/*.rds
