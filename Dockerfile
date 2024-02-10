# docker build . --platform linux/amd64,linux/arm64 -t odayny/kube-rclone:v1 --push    
FROM alpine:3.19.1

ARG TARGETARCH
# linux anyways
ARG TARGETOS
ARG RCLONE_VERSION=1.65.2

RUN apk add --no-cache --virtual=build-dependencies wget unzip && \
    wget -q https://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-${TARGETOS}-${TARGETARCH}.zip -O /tmp/rclone.zip && \
    unzip /tmp/rclone.zip -d /tmp && \
    mv /tmp/rclone-v${RCLONE_VERSION}-${TARGETOS}-${TARGETARCH}/rclone /usr/bin

RUN apk -U add curl fuse ca-certificates && \
    rm -rf /var/cache/apk/*

RUN apk del --purge build-dependencies && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

ENTRYPOINT ["/usr/bin/rclone"]
