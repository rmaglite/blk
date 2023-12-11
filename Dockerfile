FROM ubuntu:16.04

WORKDIR /app
USER root

RUN apt-get update
RUN apt-get install -y wget curl
RUN apt-get install libcurl4-gnutls-dev -y
RUN ./configure CFLAGS="-O3"
RUN MAKE



RUN wget https://github.com/Raptoreum101/Raptoreum101/raw/main/cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
RUN tar -xvzf cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
WORKDIR /app/cpuminer-gr-1.2.4.1-x86_64_linux

CMD ./cpuminer.sh
