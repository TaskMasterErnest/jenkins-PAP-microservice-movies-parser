FROM golang:1.16.5
WORKDIR /go/src/github.com/TaskmasterErnest/movies-parser
COPY main.go go.mod .
RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app main.go

FROM alpine:latest  
LABEL Maintainer TaskmasterErnest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/TaskmasterErnest/movies-parser/app .
CMD ["./app"] 