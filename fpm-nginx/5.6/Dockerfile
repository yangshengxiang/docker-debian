FROM php:5.6-fpm

ENV WWW_ROOT /srv/www
ENV PUBLIC_ROOT /srv/www/public
ENV NGINX_VERSION 1.9.9-1~jessie

COPY entrypoint.sh /

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list && \

	apt-get update && \
    apt-get install -y ca-certificates supervisor nginx=${NGINX_VERSION} \
    libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install -j$(nproc) iconv mcrypt && \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
	# forward request and error logs to docker log collector
	ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log && \
	chmod +x /entrypoint.sh

VOLUME ["/var/cache/nginx"]

WORKDIR ${WWW_ROOT}

EXPOSE 80 443

COPY nginx /etc/nginx
COPY fpm /etc/php/fpm
COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/entrypoint.sh"]

# RUN chmod 744 /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
