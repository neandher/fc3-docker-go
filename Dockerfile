FROM golang:alpine AS build 

WORKDIR /app

COPY *.go ./

RUN go mod init hello
RUN CGO_ENABLED=0 go build -o hello-world .
RUN rm go.mod
RUN rm hello-world.go

FROM scratch

WORKDIR /app

COPY --from=build /app /bin

CMD [ "hello-world" ]