# renovate: versioning=regex:^ubuntu-mate-.+-ls(?<major>\d+)$
FROM linuxserver/webtop:ubuntu-mate-d4b32207-ls41

ARG TARGETPLATFORM

# renovate: datasource=github-releases depName=rclone/rclone
ARG RCLONE_VERSION=v1.57.0
RUN RCLONE_PLATFORM=$(echo $TARGETPLATFORM | sed 's|/|-|g' ) && \
    curl -fL -o /tmp/rclone.deb https://github.com/rclone/rclone/releases/download/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-${RCLONE_PLATFORM}.deb && \
    apt install -y /tmp/rclone.deb && \
    rm /tmp/rclone.deb

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fuse \
    && rm -rf /var/lib/apt/lists/*

COPY root/ /
