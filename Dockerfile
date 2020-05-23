FROM gradle:5.6.4-jdk11 AS builder
ARG PROJECT_NAME="spring-boot-example"

COPY . /app

RUN set -x \
    && cd /app \
    && ./gradlew build \
    && mkdir -p build/dependency \
    && (cd build/dependency; jar -xf ../libs/*.jar)

FROM openjdk:8-jre-alpine
ARG DEPENDENCY=/app/dependency
RUN set -x \
    && addgroup -S spring \
    && adduser -S spring -G spring

COPY --from=builder ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=builder ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=builder ${DEPENDENCY}/BOOT-INF/classes /app

USER spring:spring
WORKDIR /app
CMD ["java","-cp","app:app/lib/*","com.example.restservice.RestServiceApplication"]
