#!/usr/bin/env sh

# prepare build environment artifact
mkdir build
git archive --format=tgz HEAD | tar -xz -C build/

# install runtime dependencies
composer install --no-interaction --no-dev --no-scripts --working-dir build/
