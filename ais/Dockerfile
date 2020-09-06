# -----------
# Build stage
# -----------

FROM ubuntu:18.04 AS build
LABEL maintainer=jwestp
WORKDIR /stk


# Install build dependencies
RUN apt-get update && \
    apt-get install -y build-essential \
                       cmake \
                       git \
                       libcurl4-openssl-dev \
                       libenet-dev \
                       libssl-dev \
                       pkg-config \
                       subversion \
                       zlib1g-dev

# Get code and assets
RUN git clone --branch 1.2 --depth=1 https://github.com/supertuxkart/stk-code.git
RUN svn checkout https://svn.code.sf.net/p/supertuxkart/code/stk-assets-release/1.1/ stk-assets

# Build server
RUN mkdir stk-code/cmake_build && \
    cd stk-code/cmake_build && \
    cmake .. -DSERVER_ONLY=ON && \
    make -j$(nproc) && \
    make install

# -----------
# Final stage
# -----------

FROM ubuntu:18.04
LABEL maintainer=jwestp
WORKDIR /stk

# Install libcurl dependency
RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy artifacts from build stage
COPY --from=build /usr/local/bin/supertuxkart /usr/local/bin
COPY --from=build /usr/local/share/supertuxkart /usr/local/share/supertuxkart

# On container startup log in with username and password if given and start the server
CMD supertuxkart --connect-now=supertuxserver:2759 --password=${SERVER_PASSWORD} --network-ai=${NUM_AIS}
