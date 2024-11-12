FROM grafana/grafana:latest

LABEL authors="dannguyenmessi"

ENV GF_PATHS_PROVISIONING=/etc/grafana/provisioning
ENV GF_AUTH_ANONYMOUS_ENABLED=true
ENV GF_AUTH_ANONYMOUS_ORG_ROLE=Admin

COPY grafana-config.yml /etc/grafana/provisioning/datasources/ds.yml

ENTRYPOINT [ "sh", "-euc", "/run.sh"]

EXPOSE 3000