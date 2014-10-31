FROM debian:wheezy
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

ENV PACKAGES wget
ENV ASSEMBLER_DIR /tmp/assembler
ENV ASSEMLBER_TAR https://example.com/assembler.tar.gz
ENV BUILD ./configure && make

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ${PACKAGES}

RUN mkdir ${ASSEMBLER_DIR}
RUN cd ${ASSEMLBER_TAR} &&\
    wget --no-check-certificate ${MEGAHIT_TAR} --output-document - |\
    tar xzf - --directory . --strip-components=1 &&\
    ${BUILD}

ADD Procfile /
ADD run /usr/local/bin/

ENTRYPOINT ["run"]
