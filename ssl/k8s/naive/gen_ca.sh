#!/bin/sh

if [ -z ${1} ]; then
    echo "please specify domain or ip. Usage: gen_ca.sh [ip_or_domain]"
    exit 1
fi

openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -subj "/CN=${1}" -days 10000 -out ca.pem
 
openssl genrsa -out master-key.pem 2048
openssl req -new -key master-key.pem -subj "/CN=${1}" -out master.csr
openssl x509 -req -in master.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out master.pem -days 10000
openssl x509 -noout -text -in ./master.pem

now="_ssl$(date "+%Y%m%d%H%M%S")"
mkdir -p $now
mv ca-key.pem ca.pem master-key.pem master.pem ca.srl master.csr $now/

ln -s naive/$now ../_ssl
