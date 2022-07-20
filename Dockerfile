FROM rust:1.62
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        curl \
        libgtk-3-dev \
        libssl-dev \
        librsvg2-dev \
        libwebkit2gtk-4.0-dev \
        libayatana-appindicator3-dev \
        wget \
    && rustup component add clippy llvm-tools-preview \
    && cargo install grcov \
    && curl -O https://gitlab.com/dlalic/rust-cobertura-xslt/-/raw/main/transform.xslt \
    && rm -rf /var/lib/apt/lists/*
