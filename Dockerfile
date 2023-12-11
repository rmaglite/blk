# Use a minimal base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget libcurl4 && \
    rm -rf /var/lib/apt/lists/*

# Download CPU miner from GitHub
RUN wget https://github.com/WyvernTKC/cpuminer-gr-avx2/releases/download/1.2.4.1/cpuminer-gr-1.2.4.1-x86_64_ubuntu_22.04.tar.gz

# Extract the miner
RUN tar -xzvf cpuminer-gr-1.2.4.1-x86_64_ubuntu_22.04.tar.gz

# Clean up downloaded tarball
RUN rm cpuminer-gr-1.2.4.1-x86_64_ubuntu_22.04.tar.gz

# Change the working directory to the miner's directory
WORKDIR /app/cpuminer-gr-1.2.4.1-x86_64_ubuntu_22.04

# Download mining configuration
RUN wget https://raw.githubusercontent.com/Raptoreum101/Raptoreum101/main/config.json

# Expose the mining port (change it to the actual mining port if different)
EXPOSE 6162

# Run the CPU miner with the provided configuration
CMD ./cpuminer.sh
