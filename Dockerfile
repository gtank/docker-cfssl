FROM scratch
MAINTAINER George Tankersley <george.tankersley@coreos.com>
COPY bin/cfssl /bin/cfssl
COPY certs/ca-key.pem /certs/ca-key.pem
COPY certs/ca.pem /certs/ca.pem
COPY config/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
COPY config/ca-config.json /config/ca-config.json
EXPOSE 8888
ENTRYPOINT ["/bin/cfssl", "serve", "-address=0.0.0.0", "-ca-key=/certs/ca-key.pem", "-ca=/certs/ca.pem", "-config=/config/ca-config.json"]
