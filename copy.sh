#!/bin/bash

echo "Copying '$1'"
rsync -av --delete "srcpkgs/$1/" "../void-packages/srcpkgs/$1"
