FROM rust:latest

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Install dependencies and build the project
RUN cargo build --release

# Expose the necessary port (if applicable)
EXPOSE 8080

# Set the entry point for the container
ENTRYPOINT ["/app/target/release/shpool"]
