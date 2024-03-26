ARG REGISTRY=my-reg
ARG DOCKER_REPO=my-repo
ARG APP_VERSION=0.1.0

FROM $REGISTRY/$DOCKER_REPO/tomcat:9.0.87-jre21-temurin

# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG REGISTRY
ARG DOCKER_REPO
ARG APP_VERSION

# dummy 
RUN mkdir -p /opt/myapp
COPY demo-${APP_VERSION}.jar /opt/myapp/demo.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/opt/myapp/demo.jar"]