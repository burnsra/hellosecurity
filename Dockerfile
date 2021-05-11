ARG baseRegistry=krogertechnology-docker.jfrog.io
FROM maven:3.6.3-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml ./pom.xml
COPY src ./src
RUN mvn clean package \
 && java -Djarmode=layertools -jar target/*.jar extract

FROM ${baseRegistry}/library/java-openjre:8-latest
LABEL org.opencontainers.image.vendor "Kroger Technology" \
  org.opencontainers.image.licenses ""
EXPOSE 8080
WORKDIR /app
COPY --from=builder /app/dependencies/ ./
COPY --from=builder /app/snapshot-dependencies/ ./
RUN true
COPY --from=builder /app/spring-boot-loader/ ./
COPY --from=builder /app/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
