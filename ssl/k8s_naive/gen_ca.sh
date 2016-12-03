#!/bin/sh

if [ -z ${MASTER_IP+x} ]; then
    echo "please specify MASTER_IP env variable"
    exit 1
fi

openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=$MASTER_IP" -days 10000 -out ca.crt
 
openssl genrsa -out server.key 2048
openssl req -new -key server.key -subj "/CN=$MASTER_IP" -out server.csr
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 10000
openssl x509 -noout -text -in ./server.crt
