FROM debian:bookworm-slim

# Combine RUN commands and clean up apt cache in the same layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    git \
    graphviz \
    musl \
    musl-tools \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone Flutter, precache, and clean up in a single layer
RUN git clone --depth 1 https://github.com/sony/flutter-elinux.git /flutter-elinux && \
    cd /flutter-elinux && \
    ./bin/flutter-elinux --version && \
    ./bin/flutter-elinux precache && \
    ./bin/flutter-elinux doctor && \
    git clean -xfd

ENV PATH=/flutter-elinux/bin:$PATH


