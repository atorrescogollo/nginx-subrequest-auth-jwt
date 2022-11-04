FROM golang:1.19 AS build
COPY . /src
WORKDIR /src
RUN go mod download
RUN CGO_ENABLED=0 go build -mod=readonly

FROM gcr.io/distroless/static:nonroot
COPY --from=build /src/nginx-subrequest-auth-jwt /
ENTRYPOINT ["/nginx-subrequest-auth-jwt"]
