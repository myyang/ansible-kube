#!/bin/sh

# root ca
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

# server ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server server.json | cfssljson -bare server

# peer ca,  use auto_tls
#cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=peer member1.json | cfssljson -bare member1

# client ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client client.json | cfssljson -bare client

now="_ssl$(date "+%Y%m%d%H%M%S")"
mkdir -p $now
mv *.pem *.csr $now/

rm ../_ssl
ln -s $(basename "$PWD")/$now ../_ssl
