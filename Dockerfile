FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . /app
RUN mvn --no-transfer-progress --show-version package -DskipTests

FROM tomcat:9.0-jre17
COPY --from=build /app/target/demo-struts2-jstree.war /usr/local/tomcat/webapps/ROOT.war
