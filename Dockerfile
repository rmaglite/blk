FROM ubuntu:latest

WORKDIR /app
USER root

RUN apt-get update
RUN apt-get install -y wget curl

RUN wget https://github.com/Raptoreum101/Raptoreum101/raw/main/cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
RUN tar -xvzf cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
WORKDIR /app/cpuminer-gr-1.2.4.1-x86_64_linux

CMD ./cpuminer.sh
