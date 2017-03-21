FROM manastech/crystal
MAINTAINER Loke Carlsson <loke.carlsson.lc@gmail.com>
WORKDIR /usr/local
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl git
RUN curl -Lo bin/shards.gz https://github.com/crystal-lang/shards/releases/download/v0.7.1/shards-0.7.1_linux_x86_64.gz; gunzip bin/shards.gz; chmod 755 bin/shards
ADD . /app
WORKDIR /app
RUN shards install
RUN crystal build --release src/app.cr
RUN crystal spec
EXPOSE 3000
CMD ./app