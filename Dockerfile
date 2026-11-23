FROM ghcr.io/ministryofjustice/laa-base-container-images/java:17-corretto-alpine

VOLUME /tmp
COPY mujina-idp/target/laa-ccms-caab-saml-mock-1.0.0.jar laa-ccms-caab-saml-mock.jar
COPY docker-idp-application.yml config/idp-application.yml
COPY mujina-idp/src/main/resources/saml-attributes.json config/saml-attributes.json
EXPOSE 8080

ENV TZ=Europe/London
ENV JAVA_TOOL_OPTIONS="-XX:InitialRAMPercentage=50.0 -XX:MaxRAMPercentage=80.0"

CMD java -Djava.security.egd=file:/dev/./urandom -jar laa-ccms-caab-saml-mock.jar --spring.config.location=config/idp-application.yml
