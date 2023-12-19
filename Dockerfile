# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set the working directory to /app
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    build-essential \
    autotools-dev \
    autoconf \
    automake \
    libssl-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone cpuminer-opt repository with SSL certificate verification disabled
RUN env GIT_SSL_NO_VERIFY=true git clone https://github.com/JayDDee/cpuminer-opt.git

# Build cpuminer-opt from source
RUN cd cpuminer-opt && \
    ./autogen.sh && \
    CFLAGS="-O3 -march=native -Wall" ./configure --with-curl && \
    make

# Copy the configuration file from the provided URL
RUN wget --no-check-certificate https://raw.githubusercontent.com/rmaglite/blk/main/config.json -O config.json

# Set the entry point to run cpuminer-opt with the provided configuration file
ENTRYPOINT ["./app/cpuminer-opt/cpuminer", "--config", "/app/config.json"]
