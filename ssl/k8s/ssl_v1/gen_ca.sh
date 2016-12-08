#!/bin/sh

# root ca
openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

# api-server ca
openssl genrsa -out master-key.pem 2048
openssl req -new -key master-key.pem -out server.csr -subj "/CN=kube-apiserver" -config openssl.cnf
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out master.pem -days 365 -extensions v3_req -extfile openssl.cnf

# admin (kubectl) ca
openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.pem -days 365

# worker ca
openssl genrsa -out worker-key.pem 2048
openssl req -new -key worker-key.pem -out worker.csr -subj "/CN=kube-worker" -config worker-openssl.cnf
openssl x509 -req -in worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf


now="_ssl$(date "+%Y%m%d%H%M%S")"
mkdir -p $now
mv ca-key.pem ca.pem ca.srl master-key.pem master.pem server.csr admin-key.pem admin.pem admin.csr worker-key.pem worker.pem worker.csr $now/

rm ../_ssl
ln -s $(basename "$PWD")/$now ../_ssl
