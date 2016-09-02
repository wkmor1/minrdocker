FROM debian:stable
MAINTAINER William K Morris <wkmor1@gmail.com>

RUN    echo "deb http://cloud.r-project.org/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list \
    && apt-key adv --keyserver keys.gnupg.net --recv-keys 381BA480 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
         r-base-dev \
         jags \
         pandoc \
         texlive-fonts-recommended \
         texlive-latex-recommended \
         wget \
         xzdec \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf var/lib/apt/lists/*

RUN    echo 'options(repos = list(CRAN = "http://cloud.r-project.org/"))' > /etc/R/Rprofile.site \
    && R -e 'install.packages(c("jagsUI", "lubridate", "purrr", "readxl", "tidyr", "tufte"))' \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN    tlmgr init-usertree \
    && tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final \
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
