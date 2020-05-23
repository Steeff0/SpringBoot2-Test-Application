FROM gradle:5.6.4-jdk11 AS builder
RUN mkdir /app
WORKDIR /app
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
RUN mkdir -p dependency && (cd dependency; jar -xf ../app.jar)

FROM openjdk:8-jre-alpine
RUN addgroup -S spring && adduser -S spring -G spring
ARG DEPENDENCY=/app/dependency
COPY --from=builder ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=builder ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=builder ${DEPENDENCY}/BOOT-INF/classes /app
USER spring:spring
WORKDIR /app
CMD ["java","-cp","app:app/lib/*","com.example.restservice.RestServiceApplication"]
