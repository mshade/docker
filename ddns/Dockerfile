FROM golang as build

ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

RUN go get -u github.com/cloudflare/cloudflare-go/cmd/flarectl && \
  go build -a -v -o / /go/src/github.com/cloudflare/cloudflare-go/cmd/flarectl


FROM alpine
LABEL maintainer="Mike Shade mshade@mshade.org"

RUN apk add --no-cache bash curl

COPY --from=build /flarectl /usr/local/bin/flarectl
COPY ./update-dns.sh /

CMD /update-dns.sh

