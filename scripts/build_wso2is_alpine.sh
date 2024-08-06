#! /bin/sh
set -e

if [[ -z "${FS_USER}" ]]; then
    echo -e "\n\tERROR: FS_USER variable not detected, refusing to run and leave files behind with incorrect ownership.\n"
    exit 1
fi

cd /tmp
git clone https://github.com/wso2/product-is --branch v7.0.0 --depth 1
cd product-is/
umask 0002
mvn clean install -Dmaven.test.skip=true
cp -rv modules/distribution/target /output/
chown -R ${FS_USER} /output/*

