FROM alpine:3.22

# Install dependencies
RUN apk add --no-cache \
      curl \
      openssl \
      socat \
      bash \
      git \
      jq \
      tzdata

# Optional: set timezone inside container
ENV TZ=UTC

# Install acme.sh
RUN curl https://get.acme.sh | bash

# Ensure acme.sh is in PATH
ENV PATH="/root/.acme.sh:${PATH}"

# Create volume for persistent cert storage
VOLUME ["/config"]

# Default entrypoint
ENTRYPOINT ["/root/.acme.sh/acme.sh"]
CMD ["--help"]
