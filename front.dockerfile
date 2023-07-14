FROM golang:1.18-alpine AS builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build  -o front ./cmd/web
RUN chmod +x /app/front

#build a tiny docker image
FROM  alpine:latest


RUN mkdir /app

COPY --from=builder /app/front /app

CMD ["/app/front"]