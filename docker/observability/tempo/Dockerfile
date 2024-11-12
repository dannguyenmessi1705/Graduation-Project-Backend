FROM grafana/tempo

LABEL authors="dannguyenmessi"

COPY tempo-config.yml /etc/tempo-config.yml

CMD ["-config.file", "/etc/tempo-config.yml"]