.PHONY: clean run cfssl req

all: certs cfssl docker

docker: Dockerfile
	docker build -t docker-cfssl -f Dockerfile .

cfssl:
	go build -a -tags netgo -installsuffix staticlinkhack -o bin/cfssl ./cfssl/cmd/cfssl/cfssl.go

certs:
	mkdir -p certs
	cfssl gencert -initca config/ca-csr.json | cfssljson -bare certs/ca

run:
	docker run -d -p 8888:8888 docker-cfssl

req:
	cfssl gencert -config config/request-config.json config/request-csr.json | cfssljson -bare certs/req

clean:
	rm -rf bin certs

