#!/usr/bin/bash

# Uses https://github.com/golf1052/base16-builder-typescript

DEST='built'

rm -rf sources
base16-builder update
ln -s $(pwd) sources/templates/vim-statusline
base16-builder build
rm $DEST/*
cp themes/vim-statusline/$DEST/* $DEST

# Can't have dashes in file names or variables.
find $DEST -type f -exec sed -i 's/-/_/g' {} \;
for file in $DEST/*; do mv $file "${file//-/_}"; done
