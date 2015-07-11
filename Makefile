.PHONY: clean run cfssl

all: certs cfssl docker

docker: Dockerfile
	docker build -t docker-cfssl -f Dockerfile .

cfssl:
	go build -a -tags netgo -installsuffix staticlinkhack -o bin/cfssl ./cfssl/cmd/cfssl/cfssl.go

certs:
	mkdir -p certs
	cfssl gencert -initca config/ca-csr.json | cfssljson -bare certs/ca

run:
	docker run -d docker-cfssl

clean:
	rm -rf bin certs

