#!/bin/bash 

RELEASE_URL="https://api.github.com/repos/brave/brave-browser/releases"

echo 'Retrieving latest releases'
RELEASES_JSON=$(curl -# $RELEASE_URL)

LATEST_RELEASE=$(jq '[.[] | select((.name | startswith("Nightly")) and (.assets[].name | contains("_amd64.deb")))][0]' <<< "$RELEASES_JSON")

if [[ $LATEST_RELEASE == "null" ]]; then
	echo 'No match.'
  exit 0
fi

LATEST_RELEASE_VERSION=$(jq -r '.tag_name[1:]' <<< "$LATEST_RELEASE")
LATEST_RELEASE_ASSETS=$(jq '[.assets[] | select(.name | contains("_amd64.deb"))]' <<< "$LATEST_RELEASE")

# LATEST_RELEASE_BIN_URL=$(jq -r '.[] | select(.name | endswith(".deb")) | .browser_download_url' <<< "$LATEST_RELEASE_ASSETS")
LATEST_RELEASE_SHA_URL=$(jq -r '.[] | select(.name | endswith(".deb.sha256")) | .browser_download_url' <<< "$LATEST_RELEASE_ASSETS")

LATEST_RELEASE_SHA=$(curl -sL $LATEST_RELEASE_SHA_URL | cut -d' ' -f 1)

sed -i -e "s|^\(version=\).*|\1${LATEST_RELEASE_VERSION}|" -e "s|^\(checksum=\).*|\1${LATEST_RELEASE_SHA}|" -e "s|^\(revision=\).*|\11|" template
