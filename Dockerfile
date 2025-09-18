# Stage 1: Build bằng Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Deploy trên Tomcat
FROM tomcat:10.1.45-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/TranQuocGiang-ex2-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
