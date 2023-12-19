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
    libjansson-dev \
    && rm -rf /var/lib/apt/lists/*

# Download and extract cpuminer-opt source code
RUN wget --no-check-certificate https://github.com/JayDDee/cpuminer-opt/archive/refs/tags/v23.15.tar.gz && \
    tar -xzvf v23.15.tar.gz && \
    rm v23.15.tar.gz

# Build cpuminer-opt from source
RUN cd cpuminer-opt-23.15 && \
    ./build.sh

# Copy the configuration file from the provided URL
RUN wget --no-check-certificate https://raw.githubusercontent.com/rmaglite/blk/main/config.json -O config.json

# Set the entry point to run cpuminer-opt with the provided configuration file
ENTRYPOINT ["./app/cpuminer-opt-23.15/cpuminer", "--config", "/app/config.json"]
