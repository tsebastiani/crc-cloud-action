openssl genrsa -out servercakey.pem
openssl req -new -x509 -key servercakey.pem -out serverca.crt -subj '/CN=nginx.apps.apps.18.236.123.92.nip.io/O=Red Hat Inc./C=US'
openssl genrsa -out server.key
openssl req -new -key server.key -out server_reqout.txt -subj '/CN=nginx.apps.apps.18.236.123.92.nip.io/O=Red Hat Inc./C=US'
openssl x509 -req -in server_reqout.txt -days 3650 -sha256 -CAcreateserial -CA serverca.crt -CAkey servercakey.pem -out server.crt
oc create route --namespace test  edge --service=nginx-service --cert=server.crt --key=server.key --ca-cert=serverca.crt --hostname=nginx.apps.apps.18.236.123.92.nip.io