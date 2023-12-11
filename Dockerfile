# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*

# Clone Raptoreum repository
RUN git clone https://github.com/Raptor3um/raptoreum.git

# Build Raptoreum
WORKDIR /raptoreum
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Set up mining configuration (replace YOUR_POOL and YOUR_WALLET)
WORKDIR /raptoreum/build/
RUN wget https://raw.githubusercontent.com/Raptoreum101/Raptoreum101/main/mining-config.txt

WORKDIR /

# Set the entry point to start mining
ENTRYPOINT ["/raptoreum/build/Raptoreum-miner"]

