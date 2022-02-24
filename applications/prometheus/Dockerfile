FROM golang:1.17

WORKDIR /app

RUN GO111MODULE=on go install github.com/prometheus/prometheus/cmd/prometheus@v2.33.1
ADD prometheus.yml /etc/prometheus/
COPY docker-entrypoint.sh /

EXPOSE 3000
ENTRYPOINT ["/docker-entrypoint.sh"]
