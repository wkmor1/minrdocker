FROM debian:testing
MAINTAINER William K Morris <wkmor1@gmail.com>

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
         r-base-dev \
         jags \
         pandoc \
         libcurl4-openssl-dev \
         texlive-fonts-recommended \
         texlive-latex-recommended \
         wget \
         xzdec \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf var/lib/apt/lists/*

RUN    echo 'options(repos = list(CRAN = "http://cloud.r-project.org/"))' > /etc/R/Rprofile.site \
    && R -e 'install.packages(c("jagsUI", "lubridate", "purrr", "readr", "readxl", "tidyr", "tufte"))' \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN    tlmgr init-usertree \
    && tlmgr update --self --all \
    && tlmgr install \
         changepage \
         framed \
         hardwrap \
         ifetex \
         ifmtarg \
         morefloats \
         paralist \
         placeins \
         sauerj \
         titlesec \
         tufte-latex \
         ulem \
         units \
         xifthen
