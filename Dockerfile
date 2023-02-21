FROM rust:1.67-alpine
RUN apk add --no-cache \
    cmake \
    gtk+3.0-dev \
    musl-dev \
    pkgconfig \
    py3-pip \
    webkit2gtk-4.1-dev \
    && rustup component add clippy llvm-tools-preview rustfmt \
    && rustup target add x86_64-apple-darwin \
    && rustup target add x86_64-linux-android \
    && pip3 install lcov_cobertura \
    && cargo install grcov \
    && cargo install junit-test
COPY MacOSX12.3.sdk.tar.xz tarballs/
RUN apk add --no-cache \
    bash \
    clang-dev \
    musl-fts-dev \
    g++ \
    git \
    gmp-dev \
    libressl-dev \
    make \
    mpc1-dev \
    mpfr-dev \
    patch \
    protoc \ 
    xz \
    && git clone https://github.com/tpoechtrager/osxcross.git --depth 1 \
    && mv tarballs/* /osxcross/tarballs \
    && TARGET_DIR=/usr/local/osxcross UNATTENDED=1 ./osxcross/build.sh \
    && rm -rf osxcross \
    && wget https://dl.google.com/android/repository/android-ndk-r25b-linux.zip \
    && unzip android-ndk-r25b-linux.zip \
    && rm -rf android-ndk-r25b-linux.zip
ENV PATH $PATH:/usr/local/osxcross/bin/
