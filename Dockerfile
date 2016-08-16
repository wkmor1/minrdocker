FROM ubuntu:trusty
MAINTAINER William K Morris <wkmor1@gmail.com>

# Install Ubuntu packages
RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
         apt-transport-https \
         curl \
         default-jdk \
         default-jre \
         gdal-bin \
         gdebi-core \
         gfortran \
         libcairo2-dev \
         lmodern \
         texinfo \
         texlive \
         texlive-humanities \
         texlive-latex-extra

# Set locale
ENV LANG        en_US.UTF-8
ENV LANGUAGE    $LANG
RUN    echo "en_US "$LANG" UTF-8" >> /etc/locale.gen \
    && locale-gen en_US $LANG \ 
    && update-locale LANG=$LANG LANGUAGE=$LANG

# Install R, RStudio, Jags
RUN    echo "deb http://ppa.launchpad.net/marutter/rrutter/ubuntu trusty main" >> /etc/apt/sources.list \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B04C661B \
    && gpg -a --export B04C661B | apt-key add - \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
         r-base-dev \
         jags \
    && R CMD javareconf \
    && echo 'options(repos = list(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' > /etc/R/Rprofile.site \
    && R -e 'install.packages(c("rJava", "readxl", "dplyr", "tidyr", "lubridate", "purrr", "magrittr", "jagsUI"))'

# Install inconsolata font
RUN    curl -O http://mirrors.ibiblio.org/pub/mirrors/CTAN/install/fonts/inconsolata.tds.zip \
    && unzip inconsolata.tds.zip -d /usr/share/texlive/texmf-dist \
    && echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \
    && cd /usr/share/texlive/texmf-dist \
    && mktexlsr \
    && updmap-sys 
    
# Clean up
RUN    apt-get clean \
    && apt-get autoremove \
    && rm -rf var/lib/apt/lists/* inconsolata.tds.zip
