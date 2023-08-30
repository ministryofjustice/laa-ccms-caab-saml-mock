FROM eclipse-temurin:17
VOLUME /tmp
COPY laa-ccms-caab-saml-mock-1.0.0.jar laa-ccms-caab-saml-mock.jar
COPY docker-idp-application.yml config/idp-application.yml
COPY mujina-idp/src/main/resources/saml-attributes.json config/saml-attributes.json
EXPOSE 8080
RUN addgroup --system --gid 800 customgroup \
    && adduser --system --uid 800 --ingroup customgroup --shell /bin/sh customuser

RUN chown customuser:customgroup laa-ccms-caab-saml-mock.jar
RUN chown -R customuser:customgroup config/
USER 800

RUN ls -l laa-ccms-caab-saml-mock.jar
ENV TZ=Europe/London
ENV JAVA_TOOL_OPTIONS="-XX:InitialRAMPercentage=50.0 -XX:MaxRAMPercentage=80.0"
CMD java -Djava.security.egd=file:/dev/./urandom -jar laa-ccms-caab-saml-mock.jar --spring.config.location=config/idp-application.yml
