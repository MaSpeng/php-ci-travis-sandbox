ARG NGINX_IMAGE

FROM ${NGINX_IMAGE}

LABEL org.opencontainers.image.authors="Marco Spengler <marco.spengler@skriptfabrik.com>"
LABEL org.opencontainers.image.vendor="https://gitlab.com/MaSpeng"
LABEL org.opencontainers.image.source="https://gitlab.com/MaSpeng/php-ci-sandbox"
LABEL org.opencontainers.image.title="NGINX"
LABEL org.opencontainers.image.description="NGIN Image for Sandbox repository to demonstrate various CI configurations"
LABEL com.maspemg.nginx_image=${NGINX_IMAGE}
LABEL com.maspeng.nginx_version=&{NGINX_VERSION}

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/*.conf /etc/nginx/conf.d
