#!/bin/bash

git remote remove github || true
git remote add github git@github.com:mcsps/k8s-releases.git
git remote -v
git fetch github
git push github --force HEAD:master || true
exit 0
