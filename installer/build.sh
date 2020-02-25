#! /bin/bash
shopt -s extglob
yarn build
cp -r src/scripts/!(*.ts) lib/scripts