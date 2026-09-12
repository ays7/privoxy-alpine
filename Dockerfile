# Use the latest stable Alpine Linux image
FROM alpine:latest

# Install Privoxy and remove the package cache to keep the image small
RUN apk add --no-cache privoxy

# Copy the default configuration file to the expected location
# (Alpine installs it to /etc/privoxy/config by default)
RUN cp /etc/privoxy/config.new /etc/privoxy/config && \
    chown -R privoxy:privoxy /etc/privoxy

# Configure Privoxy to accept connections from outside the container
# By default, it only listens on 127.0.0.1:8118
RUN sed -i 's/listen-address  127.0.0.1:8118/listen-address  0.0.0.0:8118/' /etc/privoxy/config

# Expose the default Privoxy port
EXPOSE 8118

# Run as the non-root privoxy user
USER privoxy

# Start Privoxy in the foreground so Docker can manage the process
CMD ["privoxy", "--no-daemon", "/etc/privoxy/config"]