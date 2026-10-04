FROM alpine:3.24
LABEL maintainer="Mike Shade mshade@mshade.org"

RUN apk add --no-cache curl jq

COPY ./update-dns.sh /

CMD ["/update-dns.sh"]
