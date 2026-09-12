# Use the latest stable Alpine Linux image
FROM alpine:latest

# Install Privoxy, prepare default configuration files, and allow external connections
RUN apk add --no-cache privoxy && \
    for f in /etc/privoxy/*.new; do [ -f "$f" ] && cp -a "$f" "${f%.new}"; done && \
    sed -i 's/listen-address  127.0.0.1:8118/listen-address  0.0.0.0:8118/' /etc/privoxy/config && \
    chown -R privoxy:privoxy /etc/privoxy

# Expose the default Privoxy port
EXPOSE 8118

# Run as the non-root privoxy user
USER privoxy

# Start Privoxy in the foreground so Docker can manage the process
CMD ["privoxy", "--no-daemon", "/etc/privoxy/config"]