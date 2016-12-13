#!/bin/sh

# root ca
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

# master ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=master master.json | cfssljson -bare master

# worker ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=worker worker.json | cfssljson -bare worker

# generate service account key
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=serviceaccount serviceaccount.json | cfssljson -bare serviceaccount

now="_ssl$(date "+%Y%m%d%H%M%S")"
mkdir -p $now
mv *.pem *.csr $now/

rm ../_ssl
ln -si $(basename "$PWD")/$now ../_ssl
