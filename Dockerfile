# Use a minimal base image
FROM alpine:latest

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apk --no-cache add curl

# Download Raptoreum static Linux binaries from GitHub
RUN curl -LJO https://github.com/Raptoreum/raptoreum/releases/latest/download/raptoreum-static-linux-x64.tar.gz

# Extract the binaries
RUN tar -xzvf raptoreum-static-linux-x64.tar.gz

# Download the custom mining configuration file
RUN curl -o mining-config.txt https://raw.githubusercontent.com/Raptoreum101/Raptoreum101/main/mining-config.txt

# Clean up downloaded tarball
RUN rm raptoreum-static-linux-x64.tar.gz

# Expose the mining port (change it to the actual mining port if different)
EXPOSE 6162

# Run the Raptoreum miner with the custom configuration file
CMD ["./raptoreumd", "--configfile=mining-config.txt", "--miner"]
