### Build staging for Jenkins
FROM alpine:latest

# File Author 
MAINTAINER Yury_Naumovich

# Update the repository sources list
RUN apk update && apk upgrade

# Install need packeges
RUN apk --no-cache add jq curl libc6-compat 

# Set locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# wordcloud
RUN mkdir /opt/wordcloud
WORKDIR /opt/wordcloud
EXPOSE 8888
