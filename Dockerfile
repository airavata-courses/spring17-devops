FROM eboraas/laravel

RUN apt-get update && apt-get install -y libz-dev libmemcached-dev
RUN apt-get install -y pkg-config
RUN apt-get install -y php-pear php5-dev
RUN pecl install memcached
#RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
