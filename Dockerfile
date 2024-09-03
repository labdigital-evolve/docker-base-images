ARG BASE_IMAGE=node:22.7-bookworm-slim

FROM $BASE_IMAGE

# Combine RUN instructions and clean up after installations
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    debian-keyring \
    debian-archive-keyring \
    apt-transport-https && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    supervisor \
    caddy \
    dumb-init && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add user so that we run as non-root
RUN groupadd app && useradd -g app app

# Create writable dir
RUN mkdir /app/ /home/app && chown app:app /app/ /home/app

# Switch to app user
USER app
WORKDIR /app