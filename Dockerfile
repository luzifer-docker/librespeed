FROM golang:alpine as builder

ENV GCO_ENABLED=0

ARG VERSION=v1.1.0

RUN set -ex \
 && apk add \
      curl \
      git \
 && git clone "https://github.com/librespeed/speedtest-go.git" /src \
 && cd /src \
 && git reset --hard "${VERSION}" \
 && go build \
      -o speedtest \
      -mod=readonly \
 && curl -sSfLo dumb-init "https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64" \
 && install -D -m755 -t /build/usr/local/bin \
      dumb-init \
      speedtest \
 && install -D -t /build/usr/local/share/speedtest/ \
      assets/* \
 && mkdir -p /build/etc/speedtest \
 && touch /build/etc/speedtest/.keep


FROM alpine

RUN set -ex \
 && apk --no-cache add \
      bash \
      coreutils

COPY --from=builder /build/               /
COPY                docker-entrypoint.sh  /usr/local/bin/

EXPOSE 8989
VOLUME ["/data"]
WORKDIR /etc/speedtest

ENTRYPOINT ["/usr/local/bin/dumb-init"]
CMD ["/bin/bash", "/usr/local/bin/docker-entrypoint.sh"]
