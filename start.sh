#!/bin/bash

mkdir ${DESTINATION:-_site}

pushd ${BUILD_DIR:-${BITBUCKET_CLONE_DIR:-.}}

chmod 555 *.py

bundle install
bundle exec jekyll build \
    --destination ${DESTINATION:-_site} \
    --config ${CONFIG_FILE:-_config.yml} \
    ${VERBOSE:+--verbose}

popd
