#!/bin/bash

# Display current API Quota
curl -H "Authorization: token ${GITHUB_OAUTH}" --silent -i https://api.github.com/ | grep "X-RateLimit-Remaining:"

git remote set-url --push origin https://oauth2:$DEPLOY_TOKEN@gitlab.dol.telekom.de/mcsps/k8s-releases.git

function checkrelease() {
  ORG=$1
  REPO=$2
  RTAG=$(curl -H "Authorization:\ token\ ${GITHUB_OAUTH}" --silent "https://api.github.com/repos/${ORG}/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
  DESC=$(curl -H "Authorization:\ token\ ${GITHUB_OAUTH}" --silent "https://api.github.com/repos/${ORG}/${REPO}/releases/latest" | jq .body)

  # if git tag | tr -d '\n' | grep ${REPO}-${RTAG} > /dev/null; then
  if git tag | grep "${REPO}-${RTAG}" > /dev/null; then
    echo "Nothing to do ${REPO}"
  else
    echo "create tag"
    git tag ${REPO}-${RTAG} 
    git push origin --tags
    if [[ "${REPO}" != "rancher" ]]; then
      echo "# Release ${RTAG}" > ${REPO}/${RTAG}.md
      echo -en ${DESC} >> ${REPO}/${RTAG}.md
    else 
      echo -en ${DESC} > ${REPO}/${RTAG}.md
    fi
    sed -i 's/"//g' ${REPO}/${RTAG}.md
    sed -i 's/\\r//g' ${REPO}/${RTAG}.md
    git add ${REPO}/${RTAG}.md
    git commit -m "add release desc"
    git push origin HEAD:${BRANCH} || true
  fi
}

function buildindex {

  cat tpl/1.rst > index.rst
  cat tpl/2.rst >> index.rst
  find kubernetes/ -name "*.md" -printf "   %p\n"  | sort -r >> index.rst
  echo "" >> index.rst
  cat tpl/3.rst >> index.rst
  find rancher/ -name "*.md" -printf "   %p\n"  | sort -r >> index.rst
  echo "" >> index.rst
  cat tpl/4.rst >> index.rst
  find terraform/ -name "*.md" -printf "   %p\n" | sort -r >> index.rst
  echo "" >> index.rst
  cat tpl/5.rst >> index.rst
  GCOUNT=$(git status --porcelain | wc -l)
    if [[ "${GCOUNT}" != "0" ]] ; then
      git add index.rst
      git commit -m "build index"
      git push origin --force HEAD:${BRANCH} || true
    fi
}

checkrelease rancher rancher
checkrelease kubenetes kubernetes
checkrelease hashicorp terraform
buildindex
