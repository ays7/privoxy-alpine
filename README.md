# privoxy-alpine

Lightweight, multi-architecture (`linux/amd64`, `linux/arm64`) [Privoxy](https://www.privoxy.org/) non-caching web proxy based on Alpine Linux.

Image: `ghcr.io/ays7/privoxy-alpine:latest`

## Quick Start

### Using Docker CLI

```bash
docker run -d \
  --name privoxy \
  --restart unless-stopped \
  -p 8118:8118 \
  ghcr.io/ays7/privoxy-alpine:latest
```

### Using Docker Compose

Create a `docker-compose.yml` (or use the one provided in this repository):

```yaml
services:
  privoxy:
    image: ghcr.io/ays7/privoxy-alpine:latest
    pull_policy: always
    container_name: privoxy
    restart: unless-stopped
    ports:
      - "8118:8118"
```

Start the container:

```bash
docker compose up -d
```

## Verify

Test the proxy with `curl`:

```bash
curl -x http://localhost:8118 http://p.p/
```

Privoxy will return its internal status page confirming the proxy is functioning.

## Custom Configuration (Optional)

To use custom Privoxy configuration settings, mount your local `config` file into `/etc/privoxy/config`:

```bash
docker run -d \
  --name privoxy \
  --restart unless-stopped \
  -p 8118:8118 \
  -v /path/to/config:/etc/privoxy/config:ro \
  ghcr.io/ays7/privoxy-alpine:latest
```

> **Note**: Make sure your custom configuration includes `listen-address 0.0.0.0:8118` so Privoxy listens on all interfaces within the container.
