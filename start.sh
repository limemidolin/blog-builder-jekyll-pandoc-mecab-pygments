#!/bin/bash

mkdir /tmp/_site

pushd $BITBUCKET_CLONE_DIR

bundle install
bundle exec jekyll build --destination /tmp/_site --config _config_production.yml

git checkout -f pages
cp -r /tmp/_site/* .
git add .

git commit "Deploy '$BITBUCKET_COMMIT'"
git push origin pages

popd
