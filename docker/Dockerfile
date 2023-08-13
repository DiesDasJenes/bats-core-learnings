FROM alpine:3.18

WORKDIR /opt
RUN apk update \
&& apk add --no-cache parallel ncurses bash gawk git coreutils gcc make && \
    mkdir -p ~/.parallel && touch ~/.parallel/will-cite \
&& adduser bats-tester -D -s /bin/bash

WORKDIR /test_frameworks
RUN git init -q && \
    git submodule add https://github.com/bats-core/bats-core.git bats && \
    git submodule add https://github.com/bats-core/bats-support.git test_helper/bats-support && \
    git submodule add https://github.com/bats-core/bats-assert.git test_helper/bats-assert && \
    git submodule add https://github.com/bats-core/bats-file.git test_helper/bats-file && \
    git submodule add https://github.com/grayhemp/bats-mock.git test_helper/bats-mock

RUN cd /test_frameworks/bats && \
         ./install.sh /usr/local

RUN cd /test_frameworks/test_helper/bats-mock && \
         ./build install

WORKDIR /home/bats-tester
USER bats-tester
ENTRYPOINT ["/bin/bash"]