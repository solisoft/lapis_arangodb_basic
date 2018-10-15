FROM ubuntu:16.04
LABEL Olivier Bonnaure <olivier@solisoft.net>

# install build dependencies
RUN apt-get -qq update && apt-get -qqy install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make curl git-core luarocks

# build/install OpenResty
ENV SRC_DIR /opt
ENV OPENRESTY_VERSION 1.13.6.1
ENV OPENRESTY_PREFIX /opt/openresty
ENV LAPIS_VERSION 1.7.0

RUN cd $SRC_DIR && curl -LOs https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz \
 && tar xzf openresty-$OPENRESTY_VERSION.tar.gz && cd openresty-$OPENRESTY_VERSION \
 && ./configure --prefix=$OPENRESTY_PREFIX \
 --with-luajit \
 --with-http_realip_module \
 --with-http_stub_status_module \
 && make && make install && rm -rf openresty-$OPENRESTY_VERSION*


RUN luarocks install --server=http://rocks.moonscript.org/manifests/leafo lapis $LAPIS_VERSION
RUN luarocks install moonscript
RUN luarocks install lapis-console
RUN luarocks install lustache

WORKDIR /var/www

ENV LAPIS_OPENRESTY $OPENRESTY_PREFIX/nginx/sbin/nginx

# Setup sample lapis project.
# RUN mv nginx.conf nginx.conf.bk && lapis new && moonc *.moon

# LAPIS_OPENRESTY=/opt/openresty/nginx/sbin/nginx lapis server production

# ENTRYPOINT lapis server && /bin/bash
# ENTRYPOINT ["lapis"]
