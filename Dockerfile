FROM ubuntu:18.04 AS base

VOLUME [ "/data", "/model" ]

RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        wget \
        unzip \
    && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get install -y \
        make \
        build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/facebookresearch/fastText/archive/v0.9.2.zip \
  && unzip v0.9.2.zip \
  && rm v0.9.2.zip \
  && cd fastText-0.9.2 \
  && make

ENTRYPOINT ["/fastText-0.9.2/fasttext"]
