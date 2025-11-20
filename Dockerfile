FROM maven:3.8.6-eclipse-temurin-11 as build
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

FROM eclipse-temurin:11-jre
WORKDIR /app

# Copy WAR and webapp-runner.jar from Maven build target directory
COPY --from=build /app/target/dependency/webapp-runner.jar webapp-runner.jar
COPY --from=build /app/target/*.war app.war

EXPOSE 8082
CMD ["java", "-jar", "webapp-runner.jar", "--port", "8082", "app.war"]
