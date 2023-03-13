FROM golang:1.17.3-alpine3.14

# Set the current working directory inside the container
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the Go binary
RUN go build -o /app/worker /app/worker/main.go
RUN go build -o /app/starter /app/starter/main.go

# Set the command to run the binary
CMD [ "/app/starter" ]
