#!/bin/bash 

PACKAGE_LISTING_URL="https://dl.google.com/linux/chrome/deb/dists/stable/main/binary-amd64/Packages"

PACKAGE_LISTING=$(curl -# $PACKAGE_LISTING_URL)

RELEVANT_PACKAGE=$(sed -n '/Package: google-chrome-unstable/,$p' <<< "$PACKAGE_LISTING")

LATEST_RELEASE_VERSION=$(awk -F'[:-] *' '/^Version: / { print $2; exit }' <<< "$RELEVANT_PACKAGE")
LATEST_RELEASE_SHA=$(awk '/^SHA256: / { print $2; exit }' <<< "$RELEVANT_PACKAGE")

sed -i -e "s|^\(version=\).*|\1${LATEST_RELEASE_VERSION}|" -e "s|^\(checksum=\).*|\1${LATEST_RELEASE_SHA}|" -e "s|^\(revision=\).*|\11|" template
