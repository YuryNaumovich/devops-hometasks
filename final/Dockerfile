### Build agent for Jenkins
FROM golang:1.16

# File Author 
MAINTAINER Yury_Naumovich

# Set locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Set ENV
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

