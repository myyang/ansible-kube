#!/bin/sh

# root ca
openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=etcd-ca"

# server ca
openssl genrsa -out server-key.pem 2048
openssl req -new -key server-key.pem -out server.csr -subj "/CN=etcd-server" -config openssl.cnf
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server.pem -days 1826 -extensions v3_req -extfile openssl.cnf

## client ca
#openssl genrsa -out admin.key 2048
#openssl req -new -key admin.key -out admin.csr -subj "/CN=kube-admin"
#openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.crt -days 365

now="_ssl$(date "+%Y%m%d%H%M%S")"
mkdir -p $now
mv ca-key.pem ca.pem ca.srl server-key.pem server.pem server.csr $now/

rm ../_ssl
ln -s $(basename "$PWD")/$now ../_ssl
