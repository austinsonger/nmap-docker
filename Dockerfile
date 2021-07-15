FROM ubuntu:18.04

MAINTAINER Austin Songer (austin@songer.pro)

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y build-essential libssh-dev openssl wget

RUN wget https://nmap.org/dist/nmap-7.91.tar.bz2 && tar -xjvf nmap-7.91.tar.bz2

WORKDIR /nmap-7.91

RUN ./configure && make && make install

FROM ubuntu:18.04

RUN apt update && apt install -y libssh-dev openssl && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/local/share/nmap/
COPY --from=0 /usr/local/share/nmap/ /usr/local/share/nmap/
COPY --from=0 /usr/local/bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/nmap"]
