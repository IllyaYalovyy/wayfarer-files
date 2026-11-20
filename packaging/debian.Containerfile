FROM docker.io/library/ubuntu:24.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates build-essential git rustup python3 dpkg-dev debhelper \
    libclang-dev libglib2.0-dev libxkbcommon-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*
RUN rustup set auto-self-update disable && rustup toolchain install 1.95.0 --profile minimal --component rustfmt,clippy
RUN cargo install just --locked --version 1.59.0
ENV PATH="/root/.cargo/bin:${PATH}"
WORKDIR /src
ENV CARGO_TARGET_DIR=/build
ENV DEB_OUTPUT_DIR=/out
CMD ["./scripts/package-deb.sh"]
