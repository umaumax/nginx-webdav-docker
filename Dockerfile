FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN echo Asia/Tokyo > /etc/timezone \
    && apt update && apt install -y \
        nginx \
        nginx-extras \
        libnginx-mod-http-dav-ext \
    && rm -rf /var/lib/apt/lists/*
# for debug
RUN apt update
RUN apt install -y \
    vim
RUN mkdir -p /var/www/dav
RUN chown www-data:www-data /var/www/dav
RUN chmod -R 755 /var/www/dav
ADD ./etc/nginx/conf.d/ /etc/nginx/conf.d/
ADD ./etc/nginx/nginx.conf /etc/nginx/
RUN unlink /etc/nginx/sites-enabled/default
RUN nginx -t
ADD entrypoint.sh /
RUN chmod +x entrypoint.sh
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443
CMD /entrypoint.sh && nginx -g "daemon off;"
