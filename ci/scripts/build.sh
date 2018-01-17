#!/usr/bin/env bash

yarn release -t ''
export GIT_TAG=$(jq -r ".version" package.json)
git reset HEAD^1

yarn build 

if [ "$TRAVIS_BRANCH" = "develop" ] && [ "$TRAVIS_COMMIT_MESSAGE" != *"ci(build): update library to version "* ]
then
    git checkout "$TRAVIS_BRANCH"
    git add lib/
    git commit -m "ci(build): update library to version ${GIT_TAG}"
    git push origin "$TRAVIS_BRANCH"
fi