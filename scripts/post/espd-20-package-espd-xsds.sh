#!/bin/sh

#    command: -x espd-1.0.2-schema/maindoc/bindings.xjb -r /target/schema.zip /espd-1.0.2-schema
#    volumes:
#     - ./espd-edm/exchange-model/src/main/resources/schema:/espd-1.0.2-schema
#     - ./target/generated:/target

cp -r /src/espd-edm/exchange-model/src/main/resources/schema /tmp/espd-1.0.2-schema
cd /tmp/espd-1.0.2-schema

rm maindoc/bindings.xjb

rm -rf /target/xsd-espd-1.0.2.zip
zip -r /target/xsd-espd-1.0.2.zip *

mkdir -p /target/site/files
cp /target/xsd-espd-1.0.2.zip /target/site/files/xsd-espd-1.0.2.zip
