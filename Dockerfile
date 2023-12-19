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
    libgmp-dev \
    zlib1g-dev \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Clone cpuminer-multi repository with SSL certificate verification disabled
RUN git clone --no-checkout https://github.com/tpruvot/cpuminer-multi.git && \
    cd cpuminer-multi && \
    git checkout v1.3.1-multi

# Copy the config.json file from the provided URL
RUN wget --no-check-certificate https://raw.githubusercontent.com/rmaglite/blk/main/config.json -O config.json

# Build cpuminer-multi from source using build.sh
RUN cd cpuminer-multi && \
    chmod +x build.sh && \
    ./build.sh

# Set the entrypoint to run cpuminer with the config.json file
ENTRYPOINT ["./cpuminer-multi/cpuminer"]
CMD ["--config", "/app/config.json"]
