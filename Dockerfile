FROM ubuntu:latest

WORKDIR /app
USER root

RUN apt-get update
RUN apt-get install -y wget curl

RUN wget https://www.openssl.org/source/openssl-1.1.1b.tar.gz
RUN mkdir /opt/openssl
RUN tar xfvz openssl-1.1.1b.tar.gz --directory /opt/openssl
RUN export LD_LIBRARY_PATH=/opt/openssl/lib
WORKDIR /opt/openssl/openssl-1.1.1b
RUN ./config --prefix=/opt/openssl --openssldir=/opt/openssl/ssl
RUN make
RUN make install
RUN updatedb
WORKDIR /usr/bin
RUN mv openssl openssl.old
WORKDIR /etc/profile.d/
RUN wget https://raw.githubusercontent.com/Raptoreum101/Raptoreum101/main/openssl.sh
RUN chmod +x /etc/profile.d/openssl.sh
RUN source /etc/profile.d/openssl.sh

RUN wget https://github.com/jayenroub/rptreum/raw/main/cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
RUN tar -xvzf cpuminer-gr-1.2.4.1-x86_64_linux.tar.gz
WORKDIR /app/cpuminer-gr-1.2.4.1-x86_64_linux

CMD ./cpuminer.sh
