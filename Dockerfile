## Start with the official rocker image (lightweight Debian)
FROM cardcorp/r-aws-java-pandoc:latest

## Mike Gahan
MAINTAINER Mike Gahan <michael.gahan@gmail.com>

## Document last time updated
ENV LAST_UPDATE=2017-01-21

## Install RJDC
WORKDIR /opt
RUN r -e 'install.packages("RJDBC")'
RUN r -e 'install.packages("data.table")'

## Download AWS Athena Driver
RUN wget https://s3.amazonaws.com/athena-downloads/drivers/AthenaJDBC41-1.0.0.jar
ENV PATH=$PATH:/opt

## Add .Rprofile
ADD Rprofile.site /etc/R/Rprofile.site
ADD Dockerfile /opt/Dockerfile

## Set working directory
WORKDIR /root

## Start R
CMD ["R"]

# SAMPLE CODE
#docker run -it -e 'AWS_ACCESS_KEY_ID=A********' \
#-e 'AWS_SECRET_ACCESS_KEY=T***********' \
#-e 'AWS_DEFAULT_REGION=us-east-1' \
#-e 'S3_BUCKET=yourbucketname' \
#mgahan/rathena