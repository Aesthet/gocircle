FROM golang:1.10 as builder
WORKDIR /go/src/github.com/mlabouardy/docker-eb-ci-mon
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .


FROM alpine:latest
MAINTAINER mlabouardy 
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/mlabouardy/docker-eb-ci-mon/app .
COPY avengers.json .
EXPOSE 3000
CMD ["./app"]
