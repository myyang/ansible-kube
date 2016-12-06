#!/bin/sh

if [ -z ${1} ]; then
    echo "please specify domain or ip. Usage: gen_ca.sh [ip_or_domain]"
    exit 1
fi

openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=${1}" -days 10000 -out ca.crt
 
openssl genrsa -out server.key 2048
openssl req -new -key server.key -subj "/CN=${1}" -out server.csr
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 10000
openssl x509 -noout -text -in ./server.crt

now="_ssl$(date "+%Y%m%d%H%M%S")"
mkdir -p $now
mv ca.key ca.crt server.key server.crt ca.srl server.csr $now/

ln -s naive/$now ../_ssl
