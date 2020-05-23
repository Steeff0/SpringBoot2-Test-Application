FROM gradle:5.6.4-jdk11 AS builder

ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} /app/

RUN set -x \
    && cd /app \
    && mkdir -p dependency \
    && (cd dependency; jar -xf ../*.jar)

FROM openjdk:8-jre-alpine
ARG DEPENDENCY=/app/dependency
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
