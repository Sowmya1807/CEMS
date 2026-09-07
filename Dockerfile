
FROM maven:3.8.8-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn -B -DskipTests dependency:resolve
COPY src ./src
RUN mvn -B -DskipTests package
FROM tomcat:8.5-jdk8
LABEL maintainer="you@example.com")
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]