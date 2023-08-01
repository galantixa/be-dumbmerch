FROM golang:1.18
WORKDIR /app
COPY . .
RUN go mod download
EXPOSE 5000
CMD [ "go", "run", "main.go" ]
