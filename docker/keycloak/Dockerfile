FROM quay.io/keycloak/keycloak:25.0.2

LABEL authors="dannguyenmessi"

ENV KC_HEALTH_ENABLE=true
ENV KEYCLOAK_ADMIN=didannguyen
ENV KEYCLOAK_ADMIN_PASSWORD=17052002
ENV KC_DB=mysql
ENV KC_DB_URL=jdbc:mysql://keycloakdb:3306/keycloakdb
ENV KC_DB_USERNAME=keycloak
ENV KC_DB_PASSWORD=17052002

COPY . /opt/keycloak/data/

CMD ["start-dev"]

EXPOSE 8080