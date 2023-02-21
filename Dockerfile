FROM rust:1.67
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        clang \
        cmake \
        curl \
        lcov \
        libgtk-3-dev \
        libssl-dev \
        librsvg2-dev \
        libwebkit2gtk-4.0-dev \
        libayatana-appindicator3-dev \
        musl-tools \
        pip \
        wget \
    && rustup component add clippy llvm-tools-preview rustfmt \
    && rustup target add x86_64-unknown-linux-musl \
    && rustup target add x86_64-apple-darwin \
    && rustup target add x86_64-linux-android \
    && pip3 install lcov_cobertura \
    && cargo install grcov \
    && cargo install junit-test \
    && rm -rf /var/lib/apt/lists/*
COPY MacOSX12.3.sdk.tar.xz tarballs/
RUN git clone https://github.com/tpoechtrager/osxcross.git --depth 1 \
  && mv tarballs/* /osxcross/tarballs \
  && TARGET_DIR=/usr/local/osxcross UNATTENDED=1 ./osxcross/build.sh \
  && rm -rf osxcross \
  && wget https://dl.google.com/android/repository/android-ndk-r25b-linux.zip \
  && unzip android-ndk-r25b-linux.zip \
  && rm -rf android-ndk-r25b-linux.zip
ENV PATH $PATH:/usr/local/osxcross/bin/
RUN apt-get update \
    && apt-get install -y \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*
