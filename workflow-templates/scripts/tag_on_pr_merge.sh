#! /usr/bin/env bash
set -e

export MY_ORG=$(echo "${GITHUB_REPOSITORY}" | awk -F / '{print tolower($1)}')
export DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
export COMMIT=$(echo "$SHA" | cut -c -7)

echo "Source branch is $GITHUB_HEAD_REF"
echo "Target branch is $GITHUB_BASE_REF"

if  [ "$GITHUB_BASE_REF" = "develop" ]; then
  export MY_APP=$(echo $(echo "${GITHUB_REPOSITORY}" | awk -F / '{print $2}')"-develop")
elif [ "$GITHUB_BASE_REF" = "main" ] || [ "$GITHUB_BASE_REF" = "master" ]; then
  export MY_APP=$(echo "${GITHUB_REPOSITORY}" | awk -F / '{print $2}')
else
  echo "Target branch must be develop, main, or master";
  exit 1
fi

docker login -u "$DOCKER_ACTOR" -p "$DOCKER_TOKEN" ghcr.io
docker pull ghcr.io/"$MY_ORG"/"$MY_APP":"pr-""$PR"

if  [ "$GITHUB_BASE_REF" = "develop" ]; then
  docker tag ghcr.io/"$MY_ORG"/"$MY_APP":"pr-""$PR" ghcr.io/"$MY_ORG"/"$MY_APP":"latest"
  docker push ghcr.io/"$MY_ORG"/"$MY_APP":"latest"
elif [[ ( $GITHUB_BASE_REF = "main"  || $GITHUB_BASE_REF = "master" ) && $GITHUB_HEAD_REF != "develop" ]]; then
  echo "Must merge PRs to develop before merging to main/master";
  exit 1
elif [ "$GITHUB_BASE_REF" = "main" ] || [ "$GITHUB_BASE_REF" = "master" ]; then
  docker tag ghcr.io/"$MY_ORG"/"$MY_APP":"pr-""$PR" ghcr.io/"$MY_ORG"/"$MY_APP":"latest-rc"
  docker push ghcr.io/"$MY_ORG"/"$MY_APP":"latest-rc"
else
  echo "Target branch must be develop, main, or master";
  exit 1
fi