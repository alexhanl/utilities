sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=tanzu.local" \
 -key ca.key \
 -out ca.crt

openssl genrsa -out harbor.tanzu.local.key 4096

openssl req -sha512 -new \
    -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=harbor.tanzu.local" \
    -key harbor.tanzu.local.key \
    -out harbor.tanzu.local.csr

cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=harbor.tanzu.local
DNS.2=harbor
DNS.3=192.168.110.11
EOF

openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in harbor.tanzu.local.csr \
    -out harbor.tanzu.local.crt

openssl x509 -inform PEM -in harbor.tanzu.local.crt -out harbor.tanzu.local.cert

mkdir -p /etc/docker/certs.d/harbor.tanzu.local/
cp harbor.tanzu.local.cert /etc/docker/certs.d/harbor.tanzu.local/
cp harbor.tanzu.local.key /etc/docker/certs.d/harbor.tanzu.local/
cp ca.crt /etc/docker/certs.d/harbor.tanzu.local/

systemctl restart docker



cp harbor.tanzu.local.crt /etc/pki/ca-trust/source/anchors/harbor.tanzu.local.crt
update-ca-trust