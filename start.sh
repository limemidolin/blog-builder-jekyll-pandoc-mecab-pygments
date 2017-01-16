#!/bin/bash

git checkout -f pages
git merge master

git remote add deploy $DEPLOY_ADDR
git subtree add --prefix=_site deploy master

jekyll build

git add .

git commit "Deploy $GIT_COMMIT_ID"
git subtree push --prefix=_site deploy master
