# Use an official Golang runtime as a parent image
FROM golang:1.16-alpine AS build

# Set the working directory to /app
WORKDIR /app

# Copy the go.mod and go.sum files to the container
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the entire source code into the container
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o worker ./worker/main.go

# Use an official Alpine image as a parent image
FROM alpine:latest

# Set the working directory to /app
WORKDIR /app

# Copy the worker binary from the build stage to the container
COPY --from=build /app/worker .

# Set the command to run the worker binary
CMD ["worker"]