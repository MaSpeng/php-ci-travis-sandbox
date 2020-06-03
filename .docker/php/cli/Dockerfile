ARG PHP_IMAGE

FROM ${PHP_IMAGE}

ENV APCU_ENABLE="Off"
ENV APCU_VERSION=5.1.18
ENV COMPOSER_VERSION=1.10.6
ENV PCOV_ENABLE="Off"
ENV PCOV_VERSION=1.0.6
ENV OPCACHE_ENABLE="Off"
ENV XDEBUG_EMABLE="Off"
ENV XDEBUG_VERSION=2.9.6

LABEL org.opencontainers.image.authors="Marco Spengler <marco.spengler@skriptfabrik.com>"
LABEL org.opencontainers.image.vendor="https://gitlab.com/MaSpeng"
LABEL org.opencontainers.image.source="https://gitlab.com/MaSpeng/php-ci-sandbox"
LABEL org.opencontainers.image.title="PHP CLI"
LABEL org.opencontainers.image.description="PHP CLI Image for Sandbox repository to demonstrate various CI configurations"
LABEL com.maspeng.php_image=${PHP_IMAGE}
LABEL com.maspeng.php_version=&{PHP_VERSION}
LABEL com.maspeng.composer_version=${COMPOSER_VERSION}

SHELL [ "/bin/sh", "-xe", "-c" ]
RUN apk add --no-cache --virtual .build-deps \
    ${PHPIZE_DEPS} \
    "coreutils=8.31-r0"

SHELL [ "/bin/sh", "-xe", "-c" ]
RUN pecl install \
    "apcu-${APCU_VERSION}" \
    "pcov-${PCOV_VERSION}" \
    "xdebug-${XDEBUG_VERSION}" \
    && rm -Rf /tmp/pear \
    && docker-php-ext-enable \
    apcu \
    pcov \
    && docker-php-ext-install "-j$(nproc)" \
    opcache

SHELL [ "/bin/ash", "-xeo", "pipefail", "-c" ]
RUN COMPOSER_SETUP="composer-setup.php" \
    && echo "$(curl -fsSL https://composer.github.io/installer.sig) -" > "${COMPOSER_SETUP}.sig"  \
    && curl -fsSL https://getcomposer.org/installer | tee "${COMPOSER_SETUP}" | sha384sum -c "${COMPOSER_SETUP}.sig" \
    && php "${COMPOSER_SETUP}" --install-dir=/usr/local/bin --filename=composer "--version=${COMPOSER_VERSION}" \
    && rm -f "${COMPOSER_SETUP}" "${COMPOSER_SETUP}.sig"

SHELL [ "/bin/ash", "-xeo", "pipefail", "-c" ]
RUN RUN_DEPS="$( \
    scanelf --needed --nobanner --recursive /usr/local \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | sort -u \
    | xargs -r apk info --installed \
    | sort -u \
    )" \
    && apk add --no-cache \
    ${RUN_DEPS}

SHELL [ "/bin/sh", "-xe", "-c" ]
RUN apk del .build-deps

SHELL [ "/bin/sh", "-xe", "-c" ]

COPY ./conf.d/*.ini ${PHP_INI_DIR}/conf.d/
COPY ./cli/docker-php-entrypoint /usr/local/bin/

WORKDIR /var/www/app
