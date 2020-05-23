FROM gradle:5.6.4-jdk11 AS builder
COPY . /app
RUN set -x \
    && cd /app \
    && ./gradlew clean bootJar \
    && mkdir -p build/dependency \
    && (cd build/dependency; jar -xf ../libs/*.jar)

FROM openjdk:8-jre-alpine
ARG DEPENDENCY=/app/build/dependency
RUN set -x \
    && addgroup -S spring \
    && adduser -S spring -G spring \
    && mkdir /app

COPY --from=builder ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=builder ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=builder ${DEPENDENCY}/BOOT-INF/classes /app

USER spring:spring
WORKDIR /app
CMD ["java","-cp",".:./lib/*","com.example.restservice.RestServiceApplication"]
