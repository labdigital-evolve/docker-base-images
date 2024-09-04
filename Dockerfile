ARG BASE_IMAGE=node:22.7-bookworm-slim

FROM $BASE_IMAGE

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ca-certificates dumb-init curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*